//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl.loggingsupport;

import robotlegs.bender.framework.api.ILogTarget;

class CallbackLogTarget implements ILogTarget {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _callback : Function;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(callback : Function) {
		_callback = callback;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function log(source : Dynamic, level : Int, timestamp : Int, message : String, params : Array<Dynamic> = null) : Void {
		_callback && _callback({
			source : source,
			level : level,
			timestamp : timestamp,
			message : message,
			params : params,

		});
	}

}

