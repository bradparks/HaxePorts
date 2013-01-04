//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl.contextsupport;

import robotlegs.bender.framework.impl.InlineUtils;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;

class CallbackExtension implements IExtension {

	/*============================================================================*/	
    /* Public Static Properties                                                   */	
    /*============================================================================*/	
    static public var staticCallback : Dynamic;
	/*============================================================================*/	
    /* Private Properties                                                         */	
    /*============================================================================*/	
    var _callback : Dynamic;
	/*============================================================================*/	
    /* Constructor                                                                */	
    /*============================================================================*/	
    public function new(callBack : Dynamic = null) {
		_callback = callBack || staticCallback;
		staticCallback = null;
	}

	/*============================================================================*/	
    /* Public Functions                                                           */	
    /*============================================================================*/	
    public function extend(context : IContext) : Void {
		_callback && InlineUtils.safelyCallBack(_callback, null, context);
	}

}

