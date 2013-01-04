//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import massive.munit.Assert;
import minject.Injector;
import robotlegs.bender.framework.impl.InlineUtils;

class TestApplyHooks {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var injector : Injector;
	/*============================================================================*//* Test Setup and Teardown                                                    *//*============================================================================*/@Before
	public function before() : Void {
		injector = new Injector();
	}

	@After
	public function after() : Void {
		injector = null;
	}

	/*============================================================================*//* Tests                                                                      *//*============================================================================*/@Test
	public function function_hooks_run() : Void {
		var callCount : Int = 0;
		InlineUtils.applyHooks([function() : Void {
			callCount++;
		}
]);
		assertThat(callCount, equalTo(1));
	}

	@Test
	public function class_hooks_run() : Void {
		var callCount : Int = 0;
		injector.map(Function, "hookCallback").toValue(function() : Void {
			callCount++;
		}
);
		InlineUtils.applyHooks([CallbackHook], injector);
		assertThat(callCount, equalTo(1));
	}

	@Test
	public function instance_hooks_run() : Void {
		var callCount : Int = 0;
		var hook : CallbackHook = new CallbackHook(function() : Void {
			callCount++;
		}
);
		InlineUtils.applyHooks([hook]);
		assertThat(callCount, equalTo(1));
	}


	public function new() {
	}
}

