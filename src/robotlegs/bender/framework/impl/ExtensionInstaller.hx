//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import flash.utils.Dictionary;
//import org.swiftsuspenders.reflection.DescribeTypeReflector;
//import org.swiftsuspenders.reflection.Reflector;
import minject.Reflector;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.ILogger;

/**

 * Installs custom extensions into a given context

 */class ExtensionInstaller {

	/*============================================================================*/	
    /* Private Properties                                                         */	
    /*============================================================================*/	
    var _uid : String;
	var _classes : Dictionary;
	var _reflector : Reflector;
	var _context : IContext;
	var _logger : ILogger;
	/*============================================================================*/	
    /* Constructor                                                                */	
    /*============================================================================*/	
    public function new(context : IContext) {
		_uid = UID.create(ExtensionInstaller);
		_classes = new Dictionary(true);
		_reflector = new Reflector(); // was DescribeTypeReflector
		_context = context;
		_logger = _context.getLogger(this);
	}

	/*============================================================================*/	
    /* Public Functions                                                           */	
    /*============================================================================*/	
    /**

	 * Installs the supplied extension

	 * @param extension An object or class implementing IExtension

	 */	public function install(extension : Dynamic) : Void {
		if(Std.is(extension, Class))  {
			//TODO:Reflect.field(_classes, Std.string(extension)) || install(new (Type.getClass(extension))());
		}

		else  {
			var extensionClass : Class<Dynamic> = _reflector.getClass(extension);
			if(Reflect.field(_classes, Std.string(extensionClass))) 
				return;
			_logger.debug("Installing extension {0}", [extension]);
			Reflect.setField(_classes, Std.string(extensionClass), true);
			extension.extend(_context);
		}

	}

	public function toString() : String {
		return _uid;
	}

}

