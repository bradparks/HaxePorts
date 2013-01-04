//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import flash.events.Event;
import flash.utils.SetTimeout;
import org.flexunit.async.Async;
/*import org.hamcrest.AssertThat;
import org.hamcrest.collection.Array;
import org.hamcrest.object.EqualTo;
import org.hamcrest.object.InstanceOf;*/
import robotlegs.bender.framework.api.LifecycleEvent;
import robotlegs.bender.framework.api.LifecycleState;
import robotlegs.bender.framework.impl.Lifecycle;
import robotlegs.bender.framework.impl.LifecycleTransition;

class TestLifecycleTransition {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var lifecycle : Lifecycle;
	var transition : LifecycleTransition;
	/*============================================================================*//* Test Setup and Teardown                                                    *//*============================================================================*/@Before
	public function before() : Void {
		var target : Dynamic = new Dynamic();
		lifecycle = new Lifecycle(target);
		transition = new LifecycleTransition("test", lifecycle);
	}

	/*============================================================================*//* Tests                                                                      *//*============================================================================*/@:meta(Test(expects="Error"))
	public function invalid_transition_throws_error() : Void {
		transition.fromStates("impossible").enter();
	}

	@Test
	public function invalid_transition_does_not_throw_when_errorListener_is_attached() : Void {
		lifecycle.addEventListener(LifecycleEvent.ERROR, function(event : LifecycleEvent) : Void {
		}
);
		transition.fromStates("impossible").enter();
	}

	@Test
	public function finalState_is_set() : Void {
		transition.toStates(LifecycleState.INITIALIZING, LifecycleState.ACTIVE).enter();
		assertThat(lifecycle.state, equalTo(LifecycleState.ACTIVE));
	}

	@Test
	public function transitionState_is_set() : Void {
		transition.toStates(LifecycleState.INITIALIZING, LifecycleState.ACTIVE).addBeforeHandler(function(message : Dynamic, callback : Function) : Void {
			setTimeout(callback, 1);
		}
).enter();
		assertThat(lifecycle.state, equalTo(LifecycleState.INITIALIZING));
	}

	@Test
	public function lifecycle_events_are_dispatched() : Void {
		var actual : Array<Dynamic> = [];
		var expected : Array<Dynamic> = [LifecycleEvent.PRE_INITIALIZE, LifecycleEvent.INITIALIZE, LifecycleEvent.POST_INITIALIZE];
		transition.withEvents(expected[0], expected[1], expected[2]);
		for(type in expected/* AS3HX WARNING could not determine type for var: type exp: EIdent(expected) type: Array<Dynamic>*/) {
			lifecycle.addEventListener(type, function(event : Event) : Void {
				actual.push(event.type);
			}
);
		}

		transition.enter();
		assertThat(actual, array(expected));
	}

	@Test
	public function listeners_are_reversed() : Void {
		var actual : Array<Dynamic> = [];
		var expected : Array<Dynamic> = [3, 2, 1];
		transition.withEvents("preEvent", "event", "postEvent").inReverse();
		lifecycle.addEventListener("event", function(event : Event) : Void {
			actual.push(1);
		}
);
		lifecycle.addEventListener("event", function(event : Event) : Void {
			actual.push(2);
		}
);
		lifecycle.addEventListener("event", function(event : Event) : Void {
			actual.push(3);
		}
);
		transition.enter();
		assertThat(actual, array(expected));
	}

	@Test
	public function callback_is_called() : Void {
		var callCount : Int = 0;
		transition.enter(function() : Void {
			callCount++;
		}
);
		assertThat(callCount, equalTo(1));
	}

	@Test
	public function beforeHandlers_are_run() : Void {
		var expected : Array<Dynamic> = ["a", "b", "c"];
		var actual : Array<Dynamic> = [];
		transition.addBeforeHandler(function() : Void {
			actual.push("a");
		}
);
		transition.addBeforeHandler(function() : Void {
			actual.push("b");
		}
);
		transition.addBeforeHandler(function() : Void {
			actual.push("c");
		}
);
		transition.enter();
		assertThat(actual, array(expected));
	}

	@Test
	public function beforeHandlers_are_run_in_reverse() : Void {
		var expected : Array<Dynamic> = ["c", "b", "a"];
		var actual : Array<Dynamic> = [];
		transition.inReverse();
		transition.addBeforeHandler(function() : Void {
			actual.push("a");
		}
);
		transition.addBeforeHandler(function() : Void {
			actual.push("b");
		}
);
		transition.addBeforeHandler(function() : Void {
			actual.push("c");
		}
);
		transition.enter();
		assertThat(actual, array(expected));
	}

	@:meta(Test(expects="Error"))
	public function beforeHandler_error_throws() : Void {
		transition.addBeforeHandler(function(message : String, callback : Function) : Void {
			callback("some error message");
		}
).enter();
	}

	@Test
	public function beforeHandler_does_not_throw_when_errorListener_is_attached() : Void {
		var expected : Error = new Error("There was a problem");
		var actual : Error = null;
		lifecycle.addEventListener(LifecycleEvent.ERROR, function(event : LifecycleEvent) : Void {
		}
);
		transition.addBeforeHandler(function(message : String, callback : Function) : Void {
			callback(expected);
		}
).enter(function(error : Error) : Void {
			actual = error;
		}
);
		assertThat(actual, equalTo(expected));
	}

	@Test
	public function invalidTransition_is_passed_to_callback_when_errorListener_is_attached() : Void {
		var actual : Dynamic = null;
		lifecycle.addEventListener(LifecycleEvent.ERROR, function(event : LifecycleEvent) : Void {
		}
);
		transition.fromStates("impossible").enter(function(error : Dynamic) : Void {
			actual = error;
		}
);
		assertThat(actual, instanceOf(Error));
	}

	@Test
	public function beforeHandlerError_reverts_state() : Void {
		var expected : String = lifecycle.state;
		lifecycle.addEventListener(LifecycleEvent.ERROR, function(event : LifecycleEvent) : Void {
		}
);
		transition.fromStates(LifecycleState.UNINITIALIZED).toStates("startState", "endState").addBeforeHandler(function(message : String, callback : Function) : Void {
			callback("There was a problem");
		}
).enter();
		assertThat(lifecycle.state, equalTo(expected));
	}

	@Test
	public function callback_is_called_if_already_transitioned() : Void {
		var callCount : Int = 0;
		transition.fromStates(LifecycleState.UNINITIALIZED).toStates("startState", "endState");
		transition.enter();
		transition.enter(function() : Void {
			callCount++;
		}
);
		assertThat(callCount, equalTo(1));
	}

	@:meta(Test(name=async))
	public function callback_added_during_transition_is_called() : Void {
		var callCount : Int = 0;
		transition.fromStates(LifecycleState.UNINITIALIZED).toStates("startState", "endState").addBeforeHandler(function(message : Dynamic, callback : Function) : Void {
			setTimeout(callback, 1);
		}
);
		transition.enter();
		transition.enter(function() : Void {
			callCount++;
		}
);
		Async.delayCall(this, function() : Void {
			assertThat(callCount, equalTo(1));
		}
, 50);
	}


	public function new() {
	}
}

