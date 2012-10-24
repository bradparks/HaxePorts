//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import org.hamcrest.Matcher;
import org.swiftsuspenders.Injector;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.ILifecycle;
import robotlegs.bender.framework.api.ILogTarget;
import robotlegs.bender.framework.api.ILogger;

class Context implements IContext {
	public var injector(getInjector, never) : Injector;
	public var logLevel(getLogLevel, setLogLevel) : Int;
	public var lifecycle(getLifecycle, never) : ILifecycle;

	/*============================================================================*/	/* Public Properties                                                          */	/*============================================================================*/	var _injector : Injector;
	/**
	 * @inheritDoc
	 */	public function getInjector() : Injector {
		return _injector;
	}

	/**
	 * @inheritDoc
	 */	public function getLogLevel() : Int {
		return _logManager.logLevel;
	}

	/**
	 * @inheritDoc
	 */	public function setLogLevel(value : Int) : Int {
		_logManager.logLevel = value;
		return value;
	}

	var _lifecycle : Lifecycle;
	/**
	 * @inheritDoc
	 */	public function getLifecycle() : ILifecycle {
		return _lifecycle;
	}

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _uid : String;
	var _logManager : LogManager;
	var _pin : Pin;
	var _configManager : ConfigManager;
	var _extensionInstaller : ExtensionInstaller;
	var _logger : ILogger;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new() {
		_injector = new Injector();
		_uid = UID.create(Context);
		_logManager = new LogManager();
		_pin = new Pin();
		setup();
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	/**
	 * @inheritDoc
	 */	public function initialize() : Void {
		_lifecycle.initialize();
	}

	/**
	 * @inheritDoc
	 */	public function destroy() : Void {
		_lifecycle.destroy();
	}

	/**
	 * @inheritDoc
	 */	public function extend() : IContext {
		for(extension in extensions/* AS3HX WARNING could not determine type for var: extension exp: EIdent(extensions) type: null*/) {
			_extensionInstaller.install(extension);
		}

		return this;
	}

	/**
	 * @inheritDoc
	 */	public function configure() : IContext {
		for(config in configs/* AS3HX WARNING could not determine type for var: config exp: EIdent(configs) type: null*/) {
			_configManager.addConfig(config);
		}

		return this;
	}

	/**
	 * @inheritDoc
	 */	public function addConfigHandler(matcher : Matcher, handler : Function) : IContext {
		_configManager.addConfigHandler(matcher, handler);
		return this;
	}

	/**
	 * @inheritDoc
	 */	public function getLogger(source : Dynamic) : ILogger {
		return _logManager.getLogger(source);
	}

	/**
	 * @inheritDoc
	 */	public function addLogTarget(target : ILogTarget) : IContext {
		_logManager.addLogTarget(target);
		return this;
	}

	/**
	 * @inheritDoc
	 */	public function detain() : IContext {
		for(instance in instances/* AS3HX WARNING could not determine type for var: instance exp: EIdent(instances) type: null*/) {
			_pin.detain(instance);
		}

		return this;
	}

	/**
	 * @inheritDoc
	 */	public function release() : IContext {
		for(instance in instances/* AS3HX WARNING could not determine type for var: instance exp: EIdent(instances) type: null*/) {
			_pin.release(instance);
		}

		return this;
	}

	public function toString() : String {
		return _uid;
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function setup() : Void {
		_injector.map(Injector).toValue(_injector);
		_injector.map(IContext).toValue(this);
		_logger = _logManager.getLogger(this);
		_lifecycle = new Lifecycle(this);
		_configManager = new ConfigManager(this);
		_extensionInstaller = new ExtensionInstaller(this);
		_lifecycle.beforeInitializing(beforeInitializing);
		_lifecycle.afterInitializing(afterInitializing);
		_lifecycle.beforeDestroying(beforeDestroying);
		_lifecycle.afterDestroying(afterDestroying);
	}

	function beforeInitializing() : Void {
		_logger.info("Initializing...");
	}

	function afterInitializing() : Void {
		_logger.info("Initialize complete");
	}

	function beforeDestroying() : Void {
		_logger.info("Destroying...");
	}

	function afterDestroying() : Void {
		_pin.flush();
		_injector.teardown();
		_logger.info("Destroy complete");
	}

}

