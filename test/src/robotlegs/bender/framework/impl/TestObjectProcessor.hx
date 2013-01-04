//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import massive.munit.Assert;
/*import org.hamcrest.collection.Array;
import org.hamcrest.core.Not;
import org.hamcrest.object.EqualTo;
import org.hamcrest.object.InstanceOf;*/
import robotlegs.bender.framework.impl.ObjectProcessor;

class TestObjectProcessor {

	/*============================================================================*/	/* Protected Properties                                                       */	/*============================================================================*/	var objectProcessor : ObjectProcessor;
	/*============================================================================*//* Test Setup and Teardown                                                    *//*============================================================================*/@Before
	public function before() : Void {
		objectProcessor = new ObjectProcessor();
	}

	/*============================================================================*//* Tests                                                                      *//*============================================================================*/@Test
	public function addObjectHandler() : Void {
		objectProcessor.addObjectHandler(instanceOf(String), new Function());
	}

	@Test
	public function addObject() : Void {
		objectProcessor.processObject({ });
	}

	@Test
	public function handler_handles_object() : Void {
		var expected : Dynamic = "string";
		var actual : Dynamic = null;
		objectProcessor.addObjectHandler(instanceOf(String), function(object : Dynamic) : Void {
			actual = object;
		}
);
		objectProcessor.processObject(expected);
		assertThat(actual, equalTo(expected));
	}

	@Test
	public function handler_does_not_handle_wrong_object() : Void {
		var expected : Dynamic = "string";
		var actual : Dynamic = null;
		objectProcessor.addObjectHandler(instanceOf(Boolean), function(object : Dynamic) : Void {
			actual = object;
		}
);
		objectProcessor.processObject(expected);
		assertThat(actual, not(expected));
	}

	@Test
	public function handlers_handle_object() : Void {
		var expected : Array<Dynamic> = ["handler1", "handler2", "handler3"];
		var actual : Array<Dynamic> = [];
		objectProcessor.addObjectHandler(instanceOf(String), createHandler(actual.push, "handler1"));
		objectProcessor.addObjectHandler(instanceOf(String), createHandler(actual.push, "handler2"));
		objectProcessor.addObjectHandler(instanceOf(String), createHandler(actual.push, "handler3"));
		objectProcessor.processObject("string");
		assertThat(actual, array(expected));
	}


	public function new() {
	}
}

