//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import massive.munit.Assert;
/*import org.hamcrest.collection.Array;
import org.hamcrest.object.EqualTo;*/
import robotlegs.bender.framework.api.LogLevel;
import robotlegs.bender.framework.impl.Logger;
import robotlegs.bender.framework.impl.loggingsupport.CallbackLogTarget;

class TestLogger {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var source : Dynamic;
	var logger : Logger;
	/*============================================================================*//* Test Setup and Teardown                                                    *//*============================================================================*/@Before
	public function before() : Void {
		source = { };
	}

	/*============================================================================*//* Tests                                                                      *//*============================================================================*/@Test
	public function source_is_passed() : Void {
		var expected : Dynamic = source;
		var actual : Dynamic;
		logger = new Logger(source, new CallbackLogTarget(function(result : Dynamic) : Void {
			actual = result.source;
		}
));
		logger.debug("hello");
		assertThat(actual, equalTo(expected));
	}

	@Test
	public function level_is_passed() : Void {
		var expected : Array<Dynamic> = [LogLevel.FATAL, LogLevel.ERROR, LogLevel.WARN, LogLevel.INFO, LogLevel.DEBUG];
		var actual : Array<Dynamic> = [];
		logger = new Logger(source, new CallbackLogTarget(function(result : Dynamic) : Void {
			actual.push(result.level);
		}
));
		logger.fatal("fatal");
		logger.error("error");
		logger.warn("warn");
		logger.info("info");
		logger.debug("debug");
		assertThat(actual, array(expected));
	}

	@Test
	public function message_is_passed() : Void {
		var expected : String = "hello";
		var actual : String;
		logger = new Logger(source, new CallbackLogTarget(function(result : Dynamic) : Void {
			actual = result.message;
		}
));
		logger.debug(expected);
		assertThat(actual, equalTo(expected));
	}

	@Test
	public function params_are_passed() : Void {
		var expected : Array<Dynamic> = [1, 2, 3];
		var actual : Array<Dynamic>;
		logger = new Logger(source, new CallbackLogTarget(function(result : Dynamic) : Void {
			actual = result.params;
		}
));
		logger.debug("hello", expected);
		assertThat(actual, equalTo(expected));
	}


	public function new() {
	}
}

