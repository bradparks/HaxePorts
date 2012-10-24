//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import flash.display.DisplayObject;
import flash.utils.Dictionary;
import org.hamcrest.Matcher;
import org.hamcrest.core.AllOf;
import org.hamcrest.core.Not;
import org.hamcrest.object.InstanceOf;
import org.swiftsuspenders.Injector;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.ILogger;
import robotlegs.bender.framework.api.LifecycleEvent;

/**
 * The config manager handles configuration files and
 * allows the installation of custom configuration handlers.
 *
 * <p>It is pre-configured to handle plain objects and classes</p>
 */class ConfigManager {

	/*============================================================================*/	/* Private Static Properties                                                  */	/*============================================================================*/	static inline var plainObjectMatcher : Matcher = allOf(instanceOf(Object), not(instanceOf(Class)), not(instanceOf(DisplayObject)));
	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _uid : String;
	var _objectProcessor : ObjectProcessor;
	var _configs : Dictionary;
	var _queue : Array<Dynamic>;
	var _injector : Injector;
	var _logger : ILogger;
	var _initialized : Bool;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(context : IContext) {
		_uid = UID.create(ConfigManager);
		_objectProcessor = new ObjectProcessor();
		_configs = new Dictionary();
		_queue = [];
		_injector = context.injector;
		_logger = context.getLogger(this);
		addConfigHandler(instanceOf(Class), handleClass);
		addConfigHandler(plainObjectMatcher, handleObject);
		// The ConfigManager should process the config queue
		// at the end of the INITIALIZE phase,
		// but *before* POST_INITIALIZE, so use low event priority
		context.lifecycle.addEventListener(LifecycleEvent.INITIALIZE, initialize, false, -100);
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	/**
	 * Process a given configuration object by running it through registered handlers.
	 * <p>If the manager is not initialized the configuration will be queued.</p>
	 * @param config The configuration object or class
	 */	public function addConfig(config : Dynamic) : Void {
		if(!Reflect.field(_configs, Std.string(config)))  {
			Reflect.setField(_configs, Std.string(config), true);
			_objectProcessor.processObject(config);
		}
	}

	/**
	 * Adds a custom configuration handlers
	 * @param matcher Pattern to match configuration objects
	 * @param handler Handler to process matching configurations
	 */	public function addConfigHandler(matcher : Matcher, handler : Function) : Void {
		_objectProcessor.addObjectHandler(matcher, handler);
	}

	public function toString() : String {
		return _uid;
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function initialize(event : LifecycleEvent) : Void {
		if(!_initialized)  {
			_initialized = true;
			processQueue();
		}
	}

	function handleClass(type : Class<Dynamic>) : Void {
		if(_initialized)  {
			_logger.debug("Already initialized. Instantiating config class {0}", [type]);
			processClass(type);
		}

		else  {
			_logger.debug("Not yet initialized. Queuing config class {0}", [type]);
			_queue.push(type);
		}

	}

	function handleObject(object : Dynamic) : Void {
		if(_initialized)  {
			_logger.debug("Already initialized. Injecting into config object {0}", [object]);
			processObject(object);
		}

		else  {
			_logger.debug("Not yet initialized. Queuing config object {0}", [object]);
			_queue.push(object);
		}

	}

	function processQueue() : Void {
		for(config in _queue/* AS3HX WARNING could not determine type for var: config exp: EIdent(_queue) type: Array<Dynamic>*/) {
			if(Std.is(config, Class))  {
				_logger.debug("Now initializing. Instantiating config class {0}", [config]);
				processClass(Type.getClass(config));
			}

			else  {
				_logger.debug("Now initializing. Injecting into config object {0}", [config]);
				processObject(config);
			}

		}

		_queue.length = 0;
	}

	function processClass(type : Class<Dynamic>) : Void {
		var config : IConfig = try cast(_injector.getInstance(type), IConfig) catch(e:Dynamic) null;
		config && config.configure();
	}

	function processObject(object : Dynamic) : Void {
		_injector.injectInto(object);
		var config : IConfig = try cast(object, IConfig) catch(e:Dynamic) null;
		config && config.configure();
	}

}

