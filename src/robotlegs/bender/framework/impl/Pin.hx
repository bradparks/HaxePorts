//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import flash.utils.Dictionary;

class Pin {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _instances : Dictionary;
	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function detain(instance : Dynamic) : Void {
		Reflect.setField(_instances, Std.string(instance), true);
	}

	public function release(instance : Dynamic) : Void {
		This is an intentional compilation error. See the README for handling the delete keyword
		delete Reflect.field(_instances, Std.string(instance));
	}

	public function flush() : Void {
		for(instance in Reflect.fields(_instances)) {
			This is an intentional compilation error. See the README for handling the delete keyword
			delete Reflect.field(_instances, instance);
		}

	}


	public function new() {
		_instances = new Dictionary(false);
	}
}

