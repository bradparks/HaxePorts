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
	function initialize(callBack : Dynamic->Dynamic = null) : Void;
	function suspend(callBack : Dynamic->Dynamic = null) : Void;
	function resume(callBack : Dynamic->Dynamic = null) : Void;
	function destroy(callBack : Dynamic->Dynamic = null) : Void;
	function beforeInitializing(handler : Dynamic->Dynamic) : ILifecycle;
	function whenInitializing(handler : Dynamic->Dynamic) : ILifecycle;
	function afterInitializing(handler : Dynamic->Dynamic) : ILifecycle;
	function beforeSuspending(handler : Dynamic->Dynamic) : ILifecycle;
	function whenSuspending(handler : Dynamic->Dynamic) : ILifecycle;
	function afterSuspending(handler : Dynamic->Dynamic) : ILifecycle;
	function beforeResuming(handler : Dynamic->Dynamic) : ILifecycle;
	function whenResuming(handler : Dynamic->Dynamic) : ILifecycle;
	function afterResuming(handler : Dynamic->Dynamic) : ILifecycle;
	function beforeDestroying(handler : Dynamic->Dynamic) : ILifecycle;
	function whenDestroying(handler : Dynamic->Dynamic) : ILifecycle;
	function afterDestroying(handler : Dynamic->Dynamic) : ILifecycle;
}

