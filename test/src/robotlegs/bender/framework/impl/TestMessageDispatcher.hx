//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import flash.utils.SetTimeout;
import massive.munit.Assert;
/*import org.flexunit.async.Async;
import org.hamcrest.collection.Array;
import org.hamcrest.object.EqualTo;
import org.hamcrest.object.IsFalse;
import org.hamcrest.object.IsTrue;*/
import robotlegs.bender.framework.impl.safelycallbacksupport.CreateAsyncHandler;
import robotlegs.bender.framework.impl.safelycallbacksupport.CreateCallbackHandlerThatErrors;
import robotlegs.bender.framework.impl.safelycallbacksupport.CreateHandler;

// TODO: extract MessageRunner tests
class TestMessageDispatcher {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var dispatcher : MessageDispatcher;
	var message : Dynamic;
	/*============================================================================*//* Test Setup and Teardown                                                    *//*============================================================================*/@Before
	public function before() : Void {
		dispatcher = new MessageDispatcher();
		message = new Dynamic();
	}

	/*============================================================================*//* Tests                                                                      *//*============================================================================*/@Test
	public function function_length_assumptions() : Void {
		var func : Function = function(a : String, b : String, c : String = "") : Void {
			assertThat(arguments.length, equalTo(2));
		}
;
		func("", "");
		assertThat(func.length, equalTo(3));
	}

	@Test
	public function addMessageHandler_runs() : Void {
		dispatcher.addMessageHandler(message, new Function());
	}

	@Test
	public function addMessageHandler_stores_handler() : Void {
		dispatcher.addMessageHandler(message, new Function());
		assertThat(dispatcher.hasMessageHandler(message), isTrue());
	}

	@Test
	public function hasMessageHandler_runs() : Void {
		dispatcher.hasMessageHandler(message);
	}

	@Test
	public function hasMessageHandler_returns_false() : Void {
		assertThat(dispatcher.hasMessageHandler(message), isFalse());
	}

	@Test
	public function hasMessageHandler_returns_true() : Void {
		dispatcher.addMessageHandler(message, new Function());
		assertThat(dispatcher.hasMessageHandler(message), isTrue());
	}

	@Test
	public function hasMessageHandler_returns_false_for_wrong_message() : Void {
		dispatcher.addMessageHandler("abcde", new Function());
		assertThat(dispatcher.hasMessageHandler(message), isFalse());
	}

	@Test
	public function removeMessageHandler_runs() : Void {
		dispatcher.removeMessageHandler(message, new Function());
	}

	@Test
	public function removeMessageHandler_removes_the_handler() : Void {
		var handler : Function = new Function();
		dispatcher.addMessageHandler(message, handler);
		dispatcher.removeMessageHandler(message, handler);
		assertThat(dispatcher.hasMessageHandler(message), isFalse());
	}

	@Test
	public function removeMessageHandler_does_not_remove_the_wrong_handler() : Void {
		var handler : Function = new Function();
		var otherHandler : Function = new Function();
		dispatcher.addMessageHandler(message, handler);
		dispatcher.addMessageHandler(message, otherHandler);
		dispatcher.removeMessageHandler(message, otherHandler);
		assertThat(dispatcher.hasMessageHandler(message), isTrue());
	}

	@Test
	public function dispatchMessage_runs() : Void {
		dispatcher.dispatchMessage(message);
	}

	@Test
	public function deaf_handler_handles_message() : Void {
		var handled : Bool = false;
		dispatcher.addMessageHandler(message, function() : Void {
			handled = true;
		}
);
		dispatcher.dispatchMessage(message);
		assertThat(handled, isTrue());
	}

	@Test
	public function handler_handles_message() : Void {
		var actualMessage : Dynamic;
		dispatcher.addMessageHandler(message, function(msg : Dynamic) : Void {
			actualMessage = msg;
		}
);
		dispatcher.dispatchMessage(message);
		assertThat(actualMessage, equalTo(message));
	}

	@Test
	public function message_is_handled_by_multiple_handlers() : Void {
		var handleCount : Int = 0;
		dispatcher.addMessageHandler(message, function() : Void {
			handleCount++;
		}
);
		dispatcher.addMessageHandler(message, function() : Void {
			handleCount++;
		}
);
		dispatcher.addMessageHandler(message, function() : Void {
			handleCount++;
		}
);
		dispatcher.dispatchMessage(message);
		assertThat(handleCount, equalTo(3));
	}

	@Test
	public function message_is_handled_by_handler_multiple_times() : Void {
		var handleCount : Int;
		dispatcher.addMessageHandler(message, function() : Void {
			handleCount++;
		}
);
		dispatcher.dispatchMessage(message);
		dispatcher.dispatchMessage(message);
		dispatcher.dispatchMessage(message);
		assertThat(handleCount, equalTo(3));
	}

	@Test
	public function handler_does_not_handle_the_wrong_message() : Void {
		var handled : Bool;
		dispatcher.addMessageHandler(message, function() : Void {
			handled = true;
		}
);
		dispatcher.dispatchMessage("abcde");
		assertThat(handled, isFalse());
	}

	@Test
	public function handler_with_callback_handles_message() : Void {
		var actualMessage : Dynamic;
		dispatcher.addMessageHandler(message, function(msg : Dynamic, callBack : Function) : Void {
			actualMessage = msg;
			callBack();
		}
);
		dispatcher.dispatchMessage(message);
		assertThat(actualMessage, equalTo(message));
	}

	@:meta(Test(name=async))
	public function async_handler_handles_message() : Void {
		var actualMessage : Dynamic;
		dispatcher.addMessageHandler(message, function(msg : Dynamic, callBack : Function) : Void {
			actualMessage = msg;
			setTimeout(callBack, 5);
		}
);
		dispatcher.dispatchMessage(message);
		delayAssertion(function() : Void {
			assertThat(actualMessage, equalTo(message));
		}
);
	}

	@Test
	public function callback_is_called_once() : Void {
		var callbackCount : Int;
		dispatcher.dispatchMessage(message, function() : Void {
			callbackCount++;
		}
);
		assertThat(callbackCount, equalTo(1));
	}

	@:meta(Test(name=async))
	public function callback_is_called_once_after_sync_handler() : Void {
		var callbackCount : Int;
		dispatcher.addMessageHandler(message, createHandler());
		dispatcher.dispatchMessage(message, function() : Void {
			callbackCount++;
		}
);
		delayAssertion(function() : Void {
			assertThat(callbackCount, equalTo(1));
		}
);
	}

	@:meta(Test(name=async))
	public function callback_is_called_once_after_async_handler() : Void {
		var callbackCount : Int;
		dispatcher.addMessageHandler(message, createAsyncHandler());
		dispatcher.dispatchMessage(message, function() : Void {
			callbackCount++;
		}
);
		delayAssertion(function() : Void {
			assertThat(callbackCount, equalTo(1));
		}
);
	}

	@:meta(Test(name=async))
	public function callback_is_called_once_after_sync_and_async_handlers() : Void {
		var callbackCount : Int;
		dispatcher.addMessageHandler(message, createAsyncHandler());
		dispatcher.addMessageHandler(message, createHandler());
		dispatcher.addMessageHandler(message, createAsyncHandler());
		dispatcher.addMessageHandler(message, createHandler());
		dispatcher.dispatchMessage(message, function() : Void {
			callbackCount++;
		}
);
		delayAssertion(function() : Void {
			assertThat(callbackCount, equalTo(1));
		}
, 100);
	}

	@Test
	public function handler_passes_error_to_callback() : Void {
		var expectedError : Dynamic = "Error";
		var actualError : Dynamic;
		dispatcher.addMessageHandler(message, function(msg : Dynamic, callBack : Function) : Void {
			callBack(expectedError);
		}
);
		dispatcher.dispatchMessage(message, function(error : Dynamic) : Void {
			actualError = error;
		}
);
		assertThat(actualError, equalTo(expectedError));
	}

	@:meta(Test(name=async))
	public function async_handler_passes_error_to_callback() : Void {
		var expectedError : Dynamic = "Error";
		var actualError : Dynamic;
		dispatcher.addMessageHandler(message, function(msg : Dynamic, callBack : Function) : Void {
			setTimeout(callBack, 5, expectedError);
		}
);
		dispatcher.dispatchMessage(message, function(error : Dynamic) : Void {
			actualError = error;
		}
);
		delayAssertion(function() : Void {
			assertThat(actualError, equalTo(expectedError));
		}
);
	}

	@Test
	public function handler_that_calls_back_more_than_once_is_ignored() : Void {
		var callbackCount : Int;
		dispatcher.addMessageHandler(message, function(msg : Dynamic, callBack : Function) : Void {
			callBack();
			callBack();
		}
);
		dispatcher.dispatchMessage(message, function(error : Dynamic) : Void {
			callbackCount++;
		}
);
		assertThat(callbackCount, equalTo(1));
	}

	@:meta(Test(name=async))
	public function async_handler_that_calls_back_more_than_once_is_ignored() : Void {
		var callbackCount : Int;
		dispatcher.addMessageHandler(message, function(msg : Dynamic, callBack : Function) : Void {
			callBack();
			callBack();
		}
);
		dispatcher.dispatchMessage(message, function(error : Dynamic) : Void {
			callbackCount++;
		}
);
		delayAssertion(function() : Void {
			assertThat(callbackCount, equalTo(1));
		}
);
	}

	@Test
	public function sync_handlers_should_run_in_order() : Void {
		for(reverse in [false, true]/* AS3HX WARNING could not determine type for var: reverse exp: EArrayDecl([EIdent(false), EIdent(true)]) type: null*/) {
			var actual : Array<Dynamic> = [];
			var expected : Array<Dynamic> = ["handler 1", "handler 2", "handler 3", "handler 4"];
			reverse && expected.reverse();
			dispatcher = new MessageDispatcher();
			dispatcher.addMessageHandler(message, createHandler(actual.push, "handler 1"));
			dispatcher.addMessageHandler(message, createHandler(actual.push, "handler 2"));
			dispatcher.addMessageHandler(message, createHandler(actual.push, "handler 3"));
			dispatcher.addMessageHandler(message, createHandler(actual.push, "handler 4"));
			dispatcher.dispatchMessage(message, null, reverse);
			assertThat("reverse=" + reverse, actual, array(expected));
		}

	}

	@:meta(Test(name=async))
	public function async_handlers_should_run_in_order() : Void {
		for(reverse in [false, true]/* AS3HX WARNING could not determine type for var: reverse exp: EArrayDecl([EIdent(false), EIdent(true)]) type: null*/) {
			var actual : Array<Dynamic> = [];
			var expected : Array<Dynamic> = ["handler 1", "handler 2", "handler 3", "handler 4"];
			reverse && expected.reverse();
			dispatcher = new MessageDispatcher();
			dispatcher.addMessageHandler(message, createAsyncHandler(actual.push, "handler 1"));
			dispatcher.addMessageHandler(message, createAsyncHandler(actual.push, "handler 2"));
			dispatcher.addMessageHandler(message, createAsyncHandler(actual.push, "handler 3"));
			dispatcher.addMessageHandler(message, createAsyncHandler(actual.push, "handler 4"));
			dispatcher.dispatchMessage(message, null, reverse);
			// gotta close over these otherwise we're just testing the latest twice :)
			(function(reverse : Bool, actual : Array<Dynamic>, expected : Array<Dynamic>) : Void {
				delayAssertion(function() : Void {
					assertThat("reverse=" + reverse, actual, array(expected));
				}
, 200);
			}
)(reverse, actual, expected);
		}

	}

	@:meta(Test(name=async))
	public function async_and_sync_handlers_should_run_in_order() : Void {
		for(reverse in [false, true]/* AS3HX WARNING could not determine type for var: reverse exp: EArrayDecl([EIdent(false), EIdent(true)]) type: null*/) {
			var actual : Array<Dynamic> = [];
			var expected : Array<Dynamic> = ["handler 1", "handler 2", "handler 3", "handler 4"];
			reverse && expected.reverse();
			dispatcher = new MessageDispatcher();
			dispatcher.addMessageHandler(message, createAsyncHandler(actual.push, "handler 1"));
			dispatcher.addMessageHandler(message, createHandler(actual.push, "handler 2"));
			dispatcher.addMessageHandler(message, createAsyncHandler(actual.push, "handler 3"));
			dispatcher.addMessageHandler(message, createHandler(actual.push, "handler 4"));
			dispatcher.dispatchMessage(message, null, reverse);
			// gotta close over these otherwise we're just testing the latest twice :)
			(function(reverse : Bool, actual : Array<Dynamic>, expected : Array<Dynamic>) : Void {
				delayAssertion(function() : Void {
					assertThat("reverse=" + reverse, actual, array(expected));
				}
, 200);
			}
)(reverse, actual, expected);
		}

	}

	@Test
	public function terminated_message_should_not_reach_further_handlers() : Void {
		for(reverse in [false, true]/* AS3HX WARNING could not determine type for var: reverse exp: EArrayDecl([EIdent(false), EIdent(true)]) type: null*/) {
			var actual : Array<Dynamic> = [];
			var expected : Array<Dynamic> = (reverse) ? ["handler 4", "handler 3 (with error)"] : ["handler 1", "handler 2", "handler 3 (with error)"];
			dispatcher = new MessageDispatcher();
			dispatcher.addMessageHandler(message, createHandler(actual.push, "handler 1"));
			dispatcher.addMessageHandler(message, createHandler(actual.push, "handler 2"));
			dispatcher.addMessageHandler(message, createCallbackHandlerThatErrors(actual.push, "handler 3 (with error)"));
			dispatcher.addMessageHandler(message, createHandler(actual.push, "handler 4"));
			dispatcher.dispatchMessage(message, null, reverse);
			assertThat("reverse=" + reverse, actual, array(expected));
		}

	}

	@:meta(Test(name=async))
	public function terminated_async_message_should_not_reach_further_handlers() : Void {
		for(reverse in [false, true]/* AS3HX WARNING could not determine type for var: reverse exp: EArrayDecl([EIdent(false), EIdent(true)]) type: null*/) {
			var actual : Array<Dynamic> = [];
			var expected : Array<Dynamic> = (reverse) ? ["handler 4", "handler 3 (with error)"] : ["handler 1", "handler 2", "handler 3 (with error)"];
			dispatcher = new MessageDispatcher();
			dispatcher.addMessageHandler(message, createAsyncHandler(actual.push, "handler 1"));
			dispatcher.addMessageHandler(message, createAsyncHandler(actual.push, "handler 2"));
			dispatcher.addMessageHandler(message, createCallbackHandlerThatErrors(actual.push, "handler 3 (with error)"));
			dispatcher.addMessageHandler(message, createAsyncHandler(actual.push, "handler 4"));
			dispatcher.dispatchMessage(message, null, reverse);
			// gotta close over these otherwise we're just testing the latest twice :)
			(function(reverse : Bool, actual : Array<Dynamic>, expected : Array<Dynamic>) : Void {
				delayAssertion(function() : Void {
					assertThat("reverse=" + reverse, actual, array(expected));
				}
, 200);
			}
)(reverse, actual, expected);
		}

	}

	@Test
	public function handler_is_only_added_once() : Void {
		var callbackCount : Int = 0;
		var handler : Function = function() : Void {
			callbackCount++;
		}
;
		dispatcher.addMessageHandler(message, handler);
		dispatcher.addMessageHandler(message, handler);
		dispatcher.dispatchMessage(message);
		assertThat(callbackCount, equalTo(1));
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function delayAssertion(closure : Function, delay : Float = 50) : Void {
		Async.delayCall(this, closure, delay);
	}


	public function new() {
	}
}

