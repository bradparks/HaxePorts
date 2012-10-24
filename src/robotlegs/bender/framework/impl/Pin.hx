//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import nme.ObjectHash<Dynamic,Dynamic>;

class Pin {

	/*============================================================================*/	
    /* Private Properties                                                         */	
    /*============================================================================*/	
    var _instances : ObjectHash<Dynamic,Bool>;
	/*============================================================================*/	
    /* Public Functions                                                           */	
    /*============================================================================*/	
    public function detain(instance : Dynamic) : Void {
		//TODO: Reflect.setField(_instances, Std.string(instance), true);
        _instances.set(instance, true);
	}

	public function release(instance : Dynamic) : Void {
		//TODO: delete Reflect.field(_instances, Std.string(instance));
        _instances.remove(instance);
	}

	public function flush() : Void {
		for(instance in Reflect.fields(_instances)) {
			//This is an intentional compilation error. See the README for handling the delete keyword
			//TODO:delete Reflect.field(_instances, instance);
            _instances.remove(instance);
		}

	}


	public function new() {
		_instances = new ObjectHash();
	}
}

