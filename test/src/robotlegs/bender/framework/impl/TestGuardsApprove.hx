//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import massive.munit.Assert;
/*import org.hamcrest.object.IsFalse;
import org.hamcrest.object.IsTrue;*/
import minject.Injector;
import robotlegs.bender.framework.impl.guardsupport.BossGuard;
import robotlegs.bender.framework.impl.guardsupport.GrumpyGuard;
import robotlegs.bender.framework.impl.guardsupport.HappyGuard;
import robotlegs.bender.framework.impl.guardsupport.JustTheMiddleManGuard;
import robotlegs.bender.framework.impl.GuardsApprove;

class TestGuardsApprove {

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
	public function grumpy_Function_returns_false() : Void {
		assertThat(guardsApprove([grumpyFunction]), isFalse());
	}

	@Test
	public function happy_Function_returns_true() : Void {
		assertThat(guardsApprove([happyFunction]), isTrue());
	}

	@Test
	public function grumpy_Class_returns_false() : Void {
		assertThat(guardsApprove([GrumpyGuard]), isFalse());
	}

	@Test
	public function happy_Class_returns_true() : Void {
		assertThat(guardsApprove([HappyGuard]), isTrue());
	}

	@Test
	public function grumpy_Instance_returns_false() : Void {
		assertThat(guardsApprove([new GrumpyGuard()]), isFalse());
	}

	@Test
	public function happy_Instance_returns_true() : Void {
		assertThat(guardsApprove([new HappyGuard()]), isTrue());
	}

	@Test
	public function guard_with_injections_returns_false_if_injected_guard_says_so() : Void {
		injector.map(BossGuard).toValue(new BossGuard(false));
		assertThat(guardsApprove([JustTheMiddleManGuard], injector), isFalse());
	}

	@Test
	public function guard_with_injections_returns_true_if_injected_guard_says_so() : Void {
		injector.map(BossGuard).toValue(new BossGuard(true));
		assertThat(guardsApprove([JustTheMiddleManGuard], injector), isTrue());
	}

	@Test
	public function guards_with_a_grumpy_Class_returns_false() : Void {
		assertThat(guardsApprove([HappyGuard, GrumpyGuard]), isFalse());
	}

	@Test
	public function guards_with_a_grumpy_Instance_returns_false() : Void {
		assertThat(guardsApprove([new HappyGuard(), new GrumpyGuard()]), isFalse());
	}

	@Test
	public function guards_with_a_grumpy_Function_returns_false() : Void {
		assertThat(guardsApprove([happyFunction, grumpyFunction]), isFalse());
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function happyFunction() : Bool {
		return true;
	}

	function grumpyFunction() : Bool {
		return false;
	}


	public function new() {
	}
}

