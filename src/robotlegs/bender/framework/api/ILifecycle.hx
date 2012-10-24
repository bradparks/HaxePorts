//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.api;

import flash.events.IEventDispatcher;

/**

 * The Robotlegs lifecycle contract

 */interface ILifecycle implements IEventDispatcher {
	var state(getState, never) : String;
	var target(getTarget, never) : Dynamic;
	var initialized(getInitialized, never) : Bool;
	var active(getActive, never) : Bool;
	var suspended(getSuspended, never) : Bool;
	var destroyed(getDestroyed, never) : Bool;

	function getState() : String;
	function getTarget() : Dynamic;
	function getInitialized() : Bool;
	function getActive() : Bool;
	function getSuspended() : Bool;
	function getDestroyed() : Bool;
	function initialize(callBack : Void -> Void = null) : Void;
	function suspend(callBack : Void -> Void = null) : Void;
	function resume(callBack : Void -> Void = null) : Void;
	function destroy(callBack : Void -> Void = null) : Void;
	function beforeInitializing(handler : Void -> Void) : ILifecycle;
	function whenInitializing(handler : Void -> Void) : ILifecycle;
	function afterInitializing(handler : Void -> Void) : ILifecycle;
	function beforeSuspending(handler : Void -> Void) : ILifecycle;
	function whenSuspending(handler : Void -> Void) : ILifecycle;
	function afterSuspending(handler : Void -> Void) : ILifecycle;
	function beforeResuming(handler : Void -> Void) : ILifecycle;
	function whenResuming(handler : Void -> Void) : ILifecycle;
	function afterResuming(handler : Void -> Void) : ILifecycle;
	function beforeDestroying(handler : Void -> Void) : ILifecycle;
	function whenDestroying(handler : Void -> Void) : ILifecycle;
	function afterDestroying(handler : Void -> Void) : ILifecycle;
}

