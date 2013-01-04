//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

//import flash.utils.SetTimeout;
/*import org.flexunit.async.Async;
import org.hamcrest.AssertThat;
import org.hamcrest.collection.Array;
import org.hamcrest.object.EqualTo;*/
import robotlegs.bender.framework.api.LifecycleEvent;
import robotlegs.bender.framework.api.LifecycleState;

class TestLifecycle {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var target : Dynamic;
	var lifecycle : Lifecycle;
	/*============================================================================*//* Test Setup and Teardown                                                    *//*============================================================================*/@Before
	public function before() : Void {
		target = new Dynamic();
		lifecycle = new Lifecycle(target);
	}

	/*============================================================================*//* Tests                                                                      *//*============================================================================*/@Test
	public function lifecycle_starts_uninitialized() : Void {
		assertThat(lifecycle.state, equalTo(LifecycleState.UNINITIALIZED));
	}

	@Test
	public function target_is_correct() : Void {
		assertThat(lifecycle.target, equalTo(target));
	}

	// ----- Basic valid transitions
	@Test
	public function initialize_turns_state_active() : Void {
		lifecycle.initialize();
		assertThat(lifecycle.state, equalTo(LifecycleState.ACTIVE));
	}

	@Test
	public function suspend_turns_state_suspended() : Void {
		lifecycle.initialize();
		lifecycle.suspend();
		assertThat(lifecycle.state, equalTo(LifecycleState.SUSPENDED));
	}

	@Test
	public function resume_turns_state_active() : Void {
		lifecycle.initialize();
		lifecycle.suspend();
		lifecycle.resume();
		assertThat(lifecycle.state, equalTo(LifecycleState.ACTIVE));
	}

	@Test
	public function destroy_turns_state_destroyed() : Void {
		lifecycle.initialize();
		lifecycle.destroy();
		assertThat(lifecycle.state, equalTo(LifecycleState.DESTROYED));
	}

	@Test
	public function typical_transition_chain_does_not_throw_errors() : Void {
		var methods : Array<Dynamic> = [lifecycle.initialize, lifecycle.suspend, lifecycle.resume, lifecycle.suspend, lifecycle.resume, lifecycle.destroy];
		assertThat(methodErrorCount(methods), equalTo(0));
	}

	// ----- Invalid transitions
	@Test
	public function from_uninitialized___suspend_resume_and_destroy_throw_errors() : Void {
		var methods : Array<Dynamic> = [lifecycle.suspend, lifecycle.resume, lifecycle.destroy];
		assertThat(methodErrorCount(methods), equalTo(3));
	}

	@:meta(Test(expects="Error"))
	public function from_suspended___initialize_throws_error() : Void {
		lifecycle.initialize();
		lifecycle.suspend();
		lifecycle.initialize();
	}

	@Test
	public function from_destroyed___initialize_suspend_and_resume_throw_errors() : Void {
		var methods : Array<Dynamic> = [lifecycle.initialize, lifecycle.suspend, lifecycle.resume];
		lifecycle.initialize();
		lifecycle.destroy();
		assertThat(methodErrorCount(methods), equalTo(3));
	}

	// ----- Events
	@Test
	public function events_are_dispatched() : Void {
		var actual : Array<Dynamic> = [];
		var expected : Array<Dynamic> = [LifecycleEvent.PRE_INITIALIZE, LifecycleEvent.INITIALIZE, LifecycleEvent.POST_INITIALIZE, LifecycleEvent.PRE_SUSPEND, LifecycleEvent.SUSPEND, LifecycleEvent.POST_SUSPEND, LifecycleEvent.PRE_RESUME, LifecycleEvent.RESUME, LifecycleEvent.POST_RESUME, LifecycleEvent.PRE_DESTROY, LifecycleEvent.DESTROY, LifecycleEvent.POST_DESTROY];
		var listener : Function = function(event : LifecycleEvent) : Void {
			actual.push(event.type);
		}
;
		for(type in expected/* AS3HX WARNING could not determine type for var: type exp: EIdent(expected) type: Array<Dynamic>*/) {
			lifecycle.addEventListener(type, listener);
		}

		lifecycle.initialize();
		lifecycle.suspend();
		lifecycle.resume();
		lifecycle.destroy();
		assertThat(actual, array(expected));
	}

	// ----- Shorthand transition handlers
	@:meta(Test(expects="Error"))
	public function whenHandler_with_more_than_1_argument_throws() : Void {
		lifecycle.whenInitializing(function(phase : String, callBack : Function) : Void {
		}
);
	}

	@:meta(Test(expects="Error"))
	public function afterHandler_with_more_than_1_argument_throws() : Void {
		lifecycle.afterInitializing(function(phase : String, callBack : Function) : Void {
		}
);
	}

	@Test
	public function when_and_afterHandlers_with_single_arguments_receive_event_types() : Void {
		var expected : Array<Dynamic> = [LifecycleEvent.INITIALIZE, LifecycleEvent.POST_INITIALIZE, LifecycleEvent.SUSPEND, LifecycleEvent.POST_SUSPEND, LifecycleEvent.RESUME, LifecycleEvent.POST_RESUME, LifecycleEvent.DESTROY, LifecycleEvent.POST_DESTROY];
		var actual : Array<Dynamic> = [];
		var handler : Function = function(type : String) : Void {
			actual.push(type);
		}
;
		lifecycle.whenInitializing(handler).afterInitializing(handler).whenSuspending(handler).afterSuspending(handler).whenResuming(handler).afterResuming(handler).whenDestroying(handler).afterDestroying(handler);
		lifecycle.initialize();
		lifecycle.suspend();
		lifecycle.resume();
		lifecycle.destroy();
		assertThat(actual, array(expected));
	}

	@Test
	public function when_and_afterHandlers_with_no_arguments_are_called() : Void {
		var callCount : Int = 0;
		var handler : Function = function() : Void {
			callCount++;
		}
;
		lifecycle.whenInitializing(handler).afterInitializing(handler).whenSuspending(handler).afterSuspending(handler).whenResuming(handler).afterResuming(handler).whenDestroying(handler).afterDestroying(handler);
		lifecycle.initialize();
		lifecycle.suspend();
		lifecycle.resume();
		lifecycle.destroy();
		assertThat(callCount, equalTo(8));
	}

	@Test
	public function before_handlers_are_executed() : Void {
		var callCount : Int = 0;
		var handler : Function = function() : Void {
			callCount++;
		}
;
		lifecycle.beforeInitializing(handler).beforeSuspending(handler).beforeResuming(handler).beforeDestroying(handler);
		lifecycle.initialize();
		lifecycle.suspend();
		lifecycle.resume();
		lifecycle.destroy();
		assertThat(callCount, equalTo(4));
	}

	@:meta(Test(name=async))
	public function async_before_handlers_are_executed() : Void {
		var callCount : Int = 0;
		var handler : Function = function(message : Dynamic, callBack : Function) : Void {
			callCount++;
			setTimeout(callback, 1);
		}
;
		lifecycle.beforeInitializing(handler).beforeSuspending(handler).beforeResuming(handler).beforeDestroying(handler);
		lifecycle.initialize(function() : Void {
			lifecycle.suspend(function() : Void {
				lifecycle.resume(function() : Void {
					lifecycle.destroy();
				}
);
			}
);
		}
);
		Async.delayCall(this, function() : Void {
			assertThat(callCount, equalTo(4));
		}
, 200);
	}

	// ----- Suspend and Destroy run backwards
	@Test
	public function suspend_runs_backwards() : Void {
		var actual : Array<Dynamic> = [];
		lifecycle.beforeSuspending(createValuePusher(actual, "before1"));
		lifecycle.beforeSuspending(createValuePusher(actual, "before2"));
		lifecycle.beforeSuspending(createValuePusher(actual, "before3"));
		lifecycle.whenSuspending(createValuePusher(actual, "when1"));
		lifecycle.whenSuspending(createValuePusher(actual, "when2"));
		lifecycle.whenSuspending(createValuePusher(actual, "when3"));
		lifecycle.afterSuspending(createValuePusher(actual, "after1"));
		lifecycle.afterSuspending(createValuePusher(actual, "after2"));
		lifecycle.afterSuspending(createValuePusher(actual, "after3"));
		lifecycle.initialize();
		lifecycle.suspend();
		assertThat(actual, array(["before3", "before2", "before1", "when3", "when2", "when1", "after3", "after2", "after1"]));
	}

	@Test
	public function destroy_runs_backwards() : Void {
		var actual : Array<Dynamic> = [];
		lifecycle.beforeDestroying(createValuePusher(actual, "before1"));
		lifecycle.beforeDestroying(createValuePusher(actual, "before2"));
		lifecycle.beforeDestroying(createValuePusher(actual, "before3"));
		lifecycle.whenDestroying(createValuePusher(actual, "when1"));
		lifecycle.whenDestroying(createValuePusher(actual, "when2"));
		lifecycle.whenDestroying(createValuePusher(actual, "when3"));
		lifecycle.afterDestroying(createValuePusher(actual, "after1"));
		lifecycle.afterDestroying(createValuePusher(actual, "after2"));
		lifecycle.afterDestroying(createValuePusher(actual, "after3"));
		lifecycle.initialize();
		lifecycle.destroy();
		assertThat(actual, array(["before3", "before2", "before1", "when3", "when2", "when1", "after3", "after2", "after1"]));
	}

	// ----- Before handlers callback message
	@Test
	public function beforeHandler_callbacks_are_passed_correct_message() : Void {
		var expected : Array<Dynamic> = [LifecycleEvent.PRE_INITIALIZE, LifecycleEvent.INITIALIZE, LifecycleEvent.POST_INITIALIZE, LifecycleEvent.PRE_SUSPEND, LifecycleEvent.SUSPEND, LifecycleEvent.POST_SUSPEND, LifecycleEvent.PRE_RESUME, LifecycleEvent.RESUME, LifecycleEvent.POST_RESUME, LifecycleEvent.PRE_DESTROY, LifecycleEvent.DESTROY, LifecycleEvent.POST_DESTROY];
		var actual : Array<Dynamic> = [];
		lifecycle.beforeInitializing(createMessagePusher(actual));
		lifecycle.whenInitializing(createMessagePusher(actual));
		lifecycle.afterInitializing(createMessagePusher(actual));
		lifecycle.beforeSuspending(createMessagePusher(actual));
		lifecycle.whenSuspending(createMessagePusher(actual));
		lifecycle.afterSuspending(createMessagePusher(actual));
		lifecycle.beforeResuming(createMessagePusher(actual));
		lifecycle.whenResuming(createMessagePusher(actual));
		lifecycle.afterResuming(createMessagePusher(actual));
		lifecycle.beforeDestroying(createMessagePusher(actual));
		lifecycle.whenDestroying(createMessagePusher(actual));
		lifecycle.afterDestroying(createMessagePusher(actual));
		lifecycle.initialize();
		lifecycle.suspend();
		lifecycle.resume();
		lifecycle.destroy();
		assertThat(actual, array(expected));
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function methodErrorCount(methods : Array<Dynamic>) : Int {
		var errorCount : Int = 0;
		for(method in methods/* AS3HX WARNING could not determine type for var: method exp: EIdent(methods) type: Array<Dynamic>*/) {
			try {
				method();
			}
			catch(error : Error) {
				errorCount++;
			}

		}

		return errorCount;
	}

	function createValuePusher(array : Array<Dynamic>, value : Dynamic) : Dynamic {
		return function() : Void {
			array.push(value);
		}
;
	}

	function createMessagePusher(array : Array<Dynamic>) : Dynamic {
		return function(message : Dynamic) : Void {
			array.push(message);
		}
;
	}


	public function new() {
	}
}

