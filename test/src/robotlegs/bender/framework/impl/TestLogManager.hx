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
import org.hamcrest.object.InstanceOf;*/
import robotlegs.bender.framework.api.ILogger;
import robotlegs.bender.framework.api.LogLevel;
import robotlegs.bender.framework.impl.LogManager;
import robotlegs.bender.framework.impl.loggingsupport.CallbackLogTarget;

class TestLogManager {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var source : Dynamic;
	var logManager : LogManager;
	/*============================================================================*//* Test Setup and Teardown                                                    *//*============================================================================*/@Before
	public function before() : Void {
		source = { };
		logManager = new LogManager();
	}

	/*============================================================================*//* Tests                                                                      *//*============================================================================*/@Test
	public function level_is_set() : Void {
		logManager.logLevel = LogLevel.WARN;
		assertThat(logManager.logLevel, equalTo(LogLevel.WARN));
	}

	@Test
	public function get_logger() : Void {
		assertThat(logManager.getLogger(source), instanceOf(ILogger));
	}

	@Test
	public function added_targets_are_logged_to() : Void {
		var expected : Array<Dynamic> = ["target1", "target2", "target3"];
		var actual : Array<Dynamic> = [];
		logManager.addLogTarget(new CallbackLogTarget(function(result : Dynamic) : Void {
			actual.push("target1");
		}
));
		logManager.addLogTarget(new CallbackLogTarget(function(result : Dynamic) : Void {
			actual.push("target2");
		}
));
		logManager.addLogTarget(new CallbackLogTarget(function(result : Dynamic) : Void {
			actual.push("target3");
		}
));
		logManager.getLogger(source).info(expected);
		assertThat(actual, array(expected));
	}


	public function new() {
	}
}

