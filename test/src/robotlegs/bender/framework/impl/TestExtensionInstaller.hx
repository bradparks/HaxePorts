//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

/*import org.hamcrest.AssertThat;
import org.hamcrest.object.EqualTo;*/
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;
import robotlegs.bender.framework.impl.contextsupport.CallbackExtension;
import robotlegs.bender.framework.impl.Context;
import robotlegs.bender.framework.impl.ExtensionInstaller;

class TestExtensionInstaller {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var context : IContext;
	var extensionManager : ExtensionInstaller;
	/*============================================================================*//* Test Setup and Teardown                                                    *//*============================================================================*/@Before
	public function before() : Void {
		context = new Context();
		extensionManager = new ExtensionInstaller(context);
	}

	/*============================================================================*//* Tests                                                                      *//*============================================================================*/@Test
	public function extension_instance_is_installed() : Void {
		var callCount : Int;
		extensionManager.install(new CallbackExtension(function() : Void {
			callCount++;
		}
));
		assertThat(callCount, equalTo(1));
	}

	@Test
	public function extension_class_is_installed() : Void {
		var callCount : Int;
		CallbackExtension.staticCallback = function() : Void {
			callCount++;
		}
;
		extensionManager.install(CallbackExtension);
		assertThat(callCount, equalTo(1));
	}

	@Test
	public function extension_is_installed_once_for_same_instance() : Void {
		var callCount : Int;
		var callback : Function = function() : Void {
			callCount++;
		}
;
		var extension : IExtension = new CallbackExtension(callback);
		extensionManager.install(extension);
		extensionManager.install(extension);
		assertThat(callCount, equalTo(1));
	}

	@Test
	public function extension_is_installed_once_for_same_class() : Void {
		var callCount : Int;
		var callback : Function = function() : Void {
			callCount++;
		}
;
		extensionManager.install(new CallbackExtension(callback));
		extensionManager.install(new CallbackExtension(callback));
		assertThat(callCount, equalTo(1));
	}


	public function new() {
	}
}

