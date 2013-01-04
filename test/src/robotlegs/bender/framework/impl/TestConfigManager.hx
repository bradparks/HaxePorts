//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import massive.munit.Assert;
/*import org.hamcrest.collection.Array;
import org.hamcrest.object.EqualTo;
import org.hamcrest.object.InstanceOf;
import org.hamcrest.object.NullValue;*/
import minject.Injector;
import robotlegs.bender.framework.api.IConfig;

class TestConfigManager {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var context : Context;
	var injector : Injector;
	var configManager : ConfigManager;
	/*============================================================================*//* Test Setup and Teardown                                                    *//*============================================================================*/@Before
	public function before() : Void {
		context = new Context();
		injector = context.injector;
		configManager = new ConfigManager(context);
	}

	/*============================================================================*//* Tests                                                                      *//*============================================================================*/@Test
	public function addConfig() : Void {
		configManager.addConfig({ });
	}

	@Test
	public function addHandler() : Void {
		configManager.addConfigHandler(instanceOf(String), new Function());
	}

	@Test
	public function handler_is_called() : Void {
		var expected : String = "config";
		var actual : Dynamic = null;
		configManager.addConfigHandler(instanceOf(String), function(config : Dynamic) : Void {
			actual = config;
		}
);
		configManager.addConfig(expected);
		assertThat(actual, equalTo(expected));
	}

	@Test
	public function plain_config_class_is_instantiated_at_initialization() : Void {
		var actual : Dynamic = null;
		configManager.addConfig(PlainConfig);
		injector.map(Function, "callback").toValue(function(config : PlainConfig) : Void {
			actual = config;
		}
);
		assertThat(actual, nullValue());
		context.initialize();
		assertThat(actual, instanceOf(PlainConfig));
	}

	@Test
	public function plain_config_class_is_instantiated_after_initialization() : Void {
		var actual : Dynamic = null;
		injector.map(Function, "callback").toValue(function(config : PlainConfig) : Void {
			actual = config;
		}
);
		context.initialize();
		configManager.addConfig(PlainConfig);
		assertThat(actual, instanceOf(PlainConfig));
	}

	@Test
	public function plain_config_object_is_injected_into_at_initialization() : Void {
		var expected : PlainConfig = new PlainConfig();
		var actual : Dynamic = null;
		configManager.addConfig(expected);
		injector.map(Function, "callback").toValue(function(config : Dynamic) : Void {
			actual = config;
		}
);
		assertThat(actual, nullValue());
		context.initialize();
		assertThat(actual, equalTo(expected));
	}

	@Test
	public function plain_config_object_is_injected_into_after_initialization() : Void {
		var expected : PlainConfig = new PlainConfig();
		var actual : Dynamic = null;
		context.initialize();
		injector.map(Function, "callback").toValue(function(config : Dynamic) : Void {
			actual = config;
		}
);
		configManager.addConfig(expected);
		assertThat(actual, equalTo(expected));
	}

	@Test
	public function configure_is_invoked_for_IConfig_object() : Void {
		var expected : TypedConfig = new TypedConfig();
		var actual : Dynamic = null;
		injector.map(Function, "callback").toValue(function(config : Dynamic) : Void {
			actual = config;
		}
);
		configManager.addConfig(expected);
		context.initialize();
		assertThat(actual, equalTo(expected));
	}

	@Test
	public function configure_is_invoked_for_IConfig_class() : Void {
		var actual : Dynamic = null;
		injector.map(Function, "callback").toValue(function(config : Dynamic) : Void {
			actual = config;
		}
);
		configManager.addConfig(TypedConfig);
		context.initialize();
		assertThat(actual, instanceOf(TypedConfig));
	}

	@Test
	public function config_queue_is_processed_after_other_initialize_listeners() : Void {
		var actual : Array<Dynamic> = [];
		injector.map(Function, "callback").toValue(function(config : Dynamic) : Void {
			actual.push("config");
		}
);
		configManager.addConfig(TypedConfig);
		context.lifecycle.whenInitializing(function() : Void {
			actual.push("listener1");
		}
);
		context.lifecycle.whenInitializing(function() : Void {
			actual.push("listener2");
		}
);
		context.initialize();
		assertThat(actual, array(["listener1", "listener2", "config"]));
	}


	public function new() {
	}
}

class PlainConfig {

	/*============================================================================*//* Public Properties                                                          *//*============================================================================*/@:meta(Inject(name="callback"))
	public var callBack : Function;
	/*============================================================================*//* Public Functions                                                           *//*============================================================================*/@:meta(PostConstruct())
	public function init() : Void {
		callBack(this);
	}


	public function new() {
	}
}

class TypedConfig implements IConfig {

	/*============================================================================*//* Public Properties                                                          *//*============================================================================*/@:meta(Inject(name="callback"))
	public var callBack : Function;
	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function configure() : Void {
		callBack(this);
	}


	public function new() {
	}
}

