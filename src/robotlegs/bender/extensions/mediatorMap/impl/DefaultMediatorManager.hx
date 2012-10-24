//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap.impl;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.utils.Dictionary;
import robotlegs.bender.extensions.mediatormap.api.IMediatorFactory;
import robotlegs.bender.extensions.mediatormap.api.IMediatorMapping;
import robotlegs.bender.extensions.mediatormap.api.MediatorFactoryEvent;

class DefaultMediatorManager {

	/*============================================================================*/	/* Private Static Properties                                                  */	/*============================================================================*/	static var UIComponentClass : Class<Dynamic>;
	static inline var flexAvailable : Bool = checkFlex();
	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _factory : IMediatorFactory;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(factory : IMediatorFactory) {
		_factory = factory;
		_factory.addEventListener(MediatorFactoryEvent.MEDIATOR_CREATE, onMediatorCreate);
		_factory.addEventListener(MediatorFactoryEvent.MEDIATOR_REMOVE, onMediatorRemove);
	}

	/*============================================================================*/	/* Private Static Functions                                                   */	/*============================================================================*/	static function checkFlex() : Bool {
		try {
			UIComponentClass = Type.getClass(Type.resolveClass("mx.core::UIComponent"));
		}
		catch(error : Error) {
		}

		return UIComponentClass != null;
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function onMediatorCreate(event : MediatorFactoryEvent) : Void {
		var mediator : Dynamic = event.mediator;
		var displayObject : DisplayObject = try cast(event.view, DisplayObject) catch(e:Dynamic) null;
		if(displayObject == null)  {
			// Non-display-object was added, initialize and exit
			initializeMediator(event.view, mediator);
			return;
		}
		// Watch this view for removal
		displayObject.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		// Is this a UIComponent that needs to be initialized?
		if(flexAvailable && (Std.is(displayObject, UIComponentClass)) && !Reflect.field(displayObject, "initialized"))  {
			displayObject.addEventListener("creationComplete", function(e : Event) : Void {
				displayObject.removeEventListener("creationComplete", arguments.callee);
				// ensure that we haven't been removed in the meantime
				if(_factory.getMediator(displayObject, event.mapping)) 
					initializeMediator(displayObject, mediator);
			}
);
		}

		else  {
			initializeMediator(displayObject, mediator);
		}
;
	}

	function onMediatorRemove(event : MediatorFactoryEvent) : Void {
		var displayObject : DisplayObject = try cast(event.view, DisplayObject) catch(e:Dynamic) null;
		if(displayObject != null) 
			displayObject.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		if(event.mediator) 
			destroyMediator(event.mediator);
	}

	function onRemovedFromStage(event : Event) : Void {
		_factory.removeMediators(event.target);
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

