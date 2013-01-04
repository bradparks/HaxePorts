//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import massive.munit.Assert;
/*import org.hamcrest.core.IsA;
import org.hamcrest.object.EqualTo;
import org.hamcrest.object.StrictlyEqualTo;*/
import minject.Injector;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;
import robotlegs.bender.framework.impl.contextsupport.CallbackExtension;

class TestContext {

	/*============================================================================*/	
    /* Private Properties                                                         */	
    /*============================================================================*/	
    var context : IContext;
	/*============================================================================*/
    /* Test Setup and Teardown                                                    */
    /*============================================================================*/
    @Before
	public function before() : Void {
		context = new Context();
	}

	/*============================================================================*/
    /* Tests                                                                      */
    /*============================================================================*/
    @Test
	public function can_instantiate() : Void {
		assertThat(context, isA(IContext));
	}

	@Test
	public function extensions_are_installed() : Void {
		var actual : IContext = null;
		var extension : IExtension = new CallbackExtension(function(error : Dynamic, context : IContext) : Void {
			actual = context;
		}
);
		context.extend(extension);
		assertThat(actual, equalTo(context));
	}

	@Test
	public function injector_is_mapped_into_itself() : Void {
		var injector : Injector = context.injector.getInstance(Injector);
		assertThat(injector, strictlyEqualTo(context.injector));
	}

	@Test
	public function detain_is_pretty_much_untestable() : Void {
		context.detain({ }, { });
	}

	@Test
	public function release_is_pretty_much_untestable() : Void {
		context.release({ }, { });
	}


	public function new() {
	}
}

