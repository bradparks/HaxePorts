//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager.impl;

import flash.display.DisplayObjectContainer;
import flash.events.EventDispatcher;
import robotlegs.bender.extensions.viewmanager.api.IViewHandler;
import robotlegs.bender.extensions.viewmanager.api.IViewManager;

@:meta(Event(name="containerAdd",type="robotlegs.bender.extensions.viewManager.impl.ViewManagerEvent"))
@:meta(Event(name="containerRemove",type="robotlegs.bender.extensions.viewManager.impl.ViewManagerEvent"))
@:meta(Event(name="handlerAdd",type="robotlegs.bender.extensions.viewManager.impl.ViewManagerEvent"))
@:meta(Event(name="handlerRemove",type="robotlegs.bender.extensions.viewManager.impl.ViewManagerEvent"))
class ViewManager extends EventDispatcher, implements IViewManager {
	public var containers(getContainers, never) : Array<DisplayObjectContainer>;

	/*============================================================================*/	/* Public Properties                                                          */	/*============================================================================*/	var _containers : Array<DisplayObjectContainer>;
	public function getContainers() : Array<DisplayObjectContainer> {
		return _containers;
	}

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _handlers : Array<IViewHandler>;
	var _registry : ContainerRegistry;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(containerRegistry : ContainerRegistry) {
		_containers = new Array<DisplayObjectContainer>();
		_handlers = new Array<IViewHandler>();
		_registry = containerRegistry;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function addContainer(container : DisplayObjectContainer) : Void {
		if(!validContainer(container)) 
			return;
		_containers.push(container);
		for(handler in _handlers/* AS3HX WARNING could not determine type for var: handler exp: EIdent(_handlers) type: Array<IViewHandler>*/) {
			_registry.addContainer(container).addHandler(handler);
		}

		dispatchEvent(new ViewManagerEvent(ViewManagerEvent.CONTAINER_ADD, container));
	}

	public function removeContainer(container : DisplayObjectContainer) : Void {
		var index : Int = _containers.indexOf(container);
		if(index == -1) 
			return;
		_containers.splice(index, 1);
		var binding : ContainerBinding = _registry.getBinding(container);
		for(handler in _handlers/* AS3HX WARNING could not determine type for var: handler exp: EIdent(_handlers) type: Array<IViewHandler>*/) {
			binding.removeHandler(handler);
		}

		dispatchEvent(new ViewManagerEvent(ViewManagerEvent.CONTAINER_REMOVE, container));
	}

	public function addViewHandler(handler : IViewHandler) : Void {
		if(_handlers.indexOf(handler) != -1) 
			return;
		_handlers.push(handler);
		for(container in _containers/* AS3HX WARNING could not determine type for var: container exp: EIdent(_containers) type: Array<DisplayObjectContainer>*/) {
			_registry.addContainer(container).addHandler(handler);
		}

		dispatchEvent(new ViewManagerEvent(ViewManagerEvent.HANDLER_ADD, null, handler));
	}

	public function removeViewHandler(handler : IViewHandler) : Void {
		var index : Int = _handlers.indexOf(handler);
		if(index == -1) 
			return;
		_handlers.splice(index, 1);
		for(container in _containers/* AS3HX WARNING could not determine type for var: container exp: EIdent(_containers) type: Array<DisplayObjectContainer>*/) {
			_registry.getBinding(container).removeHandler(handler);
		}

		dispatchEvent(new ViewManagerEvent(ViewManagerEvent.HANDLER_REMOVE, null, handler));
	}

	public function removeAllHandlers() : Void {
		for(container in _containers/* AS3HX WARNING could not determine type for var: container exp: EIdent(_containers) type: Array<DisplayObjectContainer>*/) {
			var binding : ContainerBinding = _registry.getBinding(container);
			for(handler in _handlers/* AS3HX WARNING could not determine type for var: handler exp: EIdent(_handlers) type: Array<IViewHandler>*/) {
				binding.removeHandler(handler);
			}

		}

	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function validContainer(container : DisplayObjectContainer) : Bool {
		for(registeredContainer in _containers/* AS3HX WARNING could not determine type for var: registeredContainer exp: EIdent(_containers) type: Array<DisplayObjectContainer>*/) {
			if(container == registeredContainer) 
				return false;
			if(registeredContainer.contains(container) || container.contains(registeredContainer)) 
				throw new Error("Containers can not be nested");
		}

		return true;
	}

}

