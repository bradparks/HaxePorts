//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl.hooksupport;

class CallbackHook {

	/*============================================================================*//* Public Properties                                                          *//*============================================================================*/@:meta(Inject(name="hookCallback",optional="true"))
	public var callback : Function;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(callback : Function = null) {
		this.callback = callback;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function hook() : Void {
		callback && callback();
	}

}

