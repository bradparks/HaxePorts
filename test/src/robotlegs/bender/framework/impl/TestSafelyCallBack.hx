//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import massive.munit.Assert;
import robotlegs.bender.framework.impl.InlineUtils;

// Assert.isTrue(a);
// Assert.isFalse(a);
// Assert.areEqual(a, b);

class TestSafelyCallBack {

	/*============================================================================*/
    /* Tests                                                                      */
    /*============================================================================*/
    
    @Test
	public function callback_with_no_params_is_called() : Void {
		var callCount : Int = 0;
		var callBack = function() : Void {
			callCount++;
		}
		InlineUtils.safelyCallBack(callBack, { }, { });
		Assert.areEqual(callCount, 1);
	}

	@Test 
	public function callback_with_one_param_is_called() : Void {
		var callCount : Int = 0;
		var callBack = function(?param : Dynamic) : Void {
			callCount++;
		}
		InlineUtils.safelyCallBack(callBack, { }, { });
		Assert.areEqual(callCount, 1);
	}

	@Test 
	public function callback_with_two_param_is_called() : Void {
		var callCount : Int = 0;
		var callBack = function(?param1 : Dynamic, ?param2 : Dynamic) : Void {
			callCount++;
		}
		InlineUtils.safelyCallBack(callBack, { }, { });
		Assert.areEqual(callCount, 1);
	}

	public function new() {
	}
}

