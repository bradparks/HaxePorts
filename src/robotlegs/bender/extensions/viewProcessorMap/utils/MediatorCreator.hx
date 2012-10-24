//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewprocessormap.utils;

import org.swiftsuspenders.Injector;
import flash.utils.Dictionary;

class MediatorCreator {

	var _mediatorClass : Class<Dynamic>;
	var _createdMediatorsByView : Dictionary;
	public function new(mediatorClass : Class<Dynamic>) {
		_createdMediatorsByView = new Dictionary(true);
		_mediatorClass = mediatorClass;
	}

	public function process(view : Dynamic, type : Class<Dynamic>, injector : Injector) : Void {
		if(Reflect.field(_createdMediatorsByView, Std.string(view)))  {
			return;
		}
		var mediator : Dynamic = injector.getInstance(_mediatorClass);
		Reflect.setField(_createdMediatorsByView, Std.string(view), mediator);
		initializeMediator(view, mediator);
	}

	public function unprocess(view : Dynamic, type : Class<Dynamic>, injector : Injector) : Void {
		if(Reflect.field(_createdMediatorsByView, Std.string(view)))  {
			destroyMediator(Reflect.field(_createdMediatorsByView, Std.string(view)));
			This is an intentional compilation error. See the README for handling the delete keyword
			delete Reflect.field(_createdMediatorsByView, Std.string(view));
		}
	}

	function initializeMediator(view : Dynamic, mediator : Dynamic) : Void {
		if(mediator.hasOwnProperty("viewComponent")) 
			mediator.viewComponent = view;
		if(mediator.hasOwnProperty("initialize")) 
			mediator.initialize();
	}

	function destroyMediator(mediator : Dynamic) : Void {
		if(mediator.hasOwnProperty("destroy")) 
			mediator.destroy();
	}

}

