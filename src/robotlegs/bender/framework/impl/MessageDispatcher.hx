//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import flash.utils.Dictionary;
import robotlegs.bender.framework.api.IMessageDispatcher;
import robotlegs.bender.framework.impl.SafelyCallBack;

/**
 * Message Dispatcher implementation.
 */class MessageDispatcher implements IMessageDispatcher {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _handlers : Dictionary;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new() {
		_handlers = new Dictionary();
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	/**
	 * @inheritDoc
	 */	public function addMessageHandler(message : Dynamic, handler : Function) : Void {
		var messageHandlers : Array<Dynamic> = Reflect.field(_handlers, Std.string(message));
		if(messageHandlers != null)  {
			if(messageHandlers.indexOf(handler) == -1) 
				messageHandlers.push(handler);
		}

		else  {
			Reflect.setField(_handlers, Std.string(message), [handler]);
		}

	}

	/**
	 * @inheritDoc
	 */	public function hasMessageHandler(message : Dynamic) : Bool {
		return Reflect.field(_handlers, Std.string(message));
	}

	/**
	 * @inheritDoc
	 */	public function removeMessageHandler(message : Dynamic, handler : Function) : Void {
		var messageHandlers : Array<Dynamic> = Reflect.field(_handlers, Std.string(message));
		var index : Int = (messageHandlers) ? messageHandlers.indexOf(handler) : -1;
		if(index != -1)  {
			messageHandlers.splice(index, 1);
			if(messageHandlers.length == 0) 
				This is an intentional compilation error. See the README for handling the delete keyword
			delete Reflect.field(_handlers, Std.string(message));
		}
	}

	/**
	 * @inheritDoc
	 */	public function dispatchMessage(message : Dynamic, callback : Function = null, reverse : Bool = false) : Void {
		var handlers : Array<Dynamic> = Reflect.field(_handlers, Std.string(message));
		if(handlers != null)  {
			handlers = handlers.concat();
			reverse || handlers.reverse();
			new MessageRunner(message, handlers, callback).run();
		}

		else  {
			callback && safelyCallBack(callback);
		}

	}

}

class MessageRunner {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _message : Dynamic;
	var _handlers : Array<Dynamic>;
	var _callback : Function;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(message : Dynamic, handlers : Array<Dynamic>, callback : Function) {
		_message = message;
		_handlers = handlers;
		_callback = callback;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function run() : Void {
		next();
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function next() : Void {
		// Try to keep things synchronous with a simple loop,
		// forcefully breaking out for async handlers and recursing.
		// We do this to avoid increasing the stack depth unnecessarily.
		var handler : Function;
		while(handler = _handlers.pop()) {
			if(handler.length == 0) 
				// sync handler: ()
			 {
				handler();
			}

			else if(handler.length == 1) 
				// sync handler: (message)
			 {
				handler(_message);
			}

			else if(handler.length == 2) 
				// sync or async handler: (message, callback)
			 {
				var handled : Bool;
				handler(_message, function(error : Dynamic = null, msg : Dynamic = null) : Void {
					// handler must not invoke the callback more than once
					if(handled) 
						return;
					handled = true;
					if(error || _handlers.length == 0)  {
						_callback && safelyCallBack(_callback, error, _message);
					}

					else  {
						next();
					}

				}
);
				// IMPORTANT: MUST break this loop with a RETURN. See top.
				return;
			}

			else // ERROR: this should NEVER happen
			 {
				throw new Error("Bad handler signature");
			}
;
		}

		// If we got here then this loop finished synchronously.
		// Nobody broke out, so we are done.
		// This relies on the various return statements above. Be careful.
		_callback && safelyCallBack(_callback, null, _message);
	}

}

