//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewprocessormap.impl;

import org.swiftsuspenders.errors.InjectorInterfaceConstructionError;
import org.swiftsuspenders.Injector;
import robotlegs.bender.extensions.matching.ITypeFilter;
import robotlegs.bender.extensions.viewprocessormap.api.ViewProcessorMapError;
import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorMapping;
import robotlegs.bender.framework.impl.ApplyHooks;
import robotlegs.bender.framework.impl.GuardsApprove;
import flash.utils.Dictionary;
import flash.display.DisplayObject;
import flash.events.Event;

class ViewProcessorFactory implements IViewProcessorFactory {

	var _injector : Injector;
	var _listenersByView : Dictionary;
	public function new(injector : Injector) {
		_listenersByView = new Dictionary(true);
		_injector = injector;
	}

	public function runProcessors(view : Dynamic, type : Class<Dynamic>, processorMappings : Array<Dynamic>) : Void {
		createRemovedListener(view, type, processorMappings);
		var filter : ITypeFilter;
		for(mapping in processorMappings/* AS3HX WARNING could not determine type for var: mapping exp: EIdent(processorMappings) type: Array<Dynamic>*/) {
			filter = mapping.matcher;
			mapTypeForFilterBinding(filter, type, view);
			runProcess(view, type, mapping);
			unmapTypeForFilterBinding(filter, type, view);
		}

	}

	public function runUnprocessors(view : Dynamic, type : Class<Dynamic>, processorMappings : Array<Dynamic>) : Void {
		for(mapping in processorMappings/* AS3HX WARNING could not determine type for var: mapping exp: EIdent(processorMappings) type: Array<Dynamic>*/) {
			// ?? Is this correct - will assume that people are implementing something sensible in their processors.
			mapping.processor ||= createProcessor(mapping.processorClass);
			mapping.processor.unprocess(view, type, _injector);
		}

	}

	public function runAllUnprocessors() : Void {
		for(removalHandlers in _listenersByView/* AS3HX WARNING could not determine type for var: removalHandlers exp: EIdent(_listenersByView) type: Dictionary*/) {
			var iLength : Int = removalHandlers.length;
			var i : Int = 0;
			while(i < iLength) {
				removalHandlers[i](null);
				i++;
			}
		}

	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function runProcess(view : Dynamic, type : Class<Dynamic>, mapping : IViewProcessorMapping) : Void {
		if(guardsApprove(mapping.guards, _injector))  {
			mapping.processor ||= createProcessor(mapping.processorClass);
			applyHooks(mapping.hooks, _injector);
			mapping.processor.process(view, type, _injector);
		}
	}

	function createProcessor(processorClass : Class<Dynamic>) : Dynamic {
		if(!_injector.satisfiesDirectly(processorClass))  {
			_injector.map(processorClass).asSingleton();
		}
		try {
			return _injector.getInstance(processorClass);
		}
		catch(error : InjectorInterfaceConstructionError) {
			var errorMsg : String = "The view processor " + processorClass + " has not been mapped in the injector, " + "and it is not possible to instantiate an interface. " + "Please map a concrete type against this interface.";
			throw (new ViewProcessorMapError(errorMsg));
		}

		return null;
	}

	function mapTypeForFilterBinding(filter : ITypeFilter, type : Class<Dynamic>, view : Dynamic) : Void {
		var requiredType : Class<Dynamic>;
		var requiredTypes : Array<Class<Dynamic>> = requiredTypesFor(filter, type);
		for(requiredType in requiredTypes/* AS3HX WARNING could not determine type for var: requiredType exp: EIdent(requiredTypes) type: Array<Class<Dynamic>>*/) {
			_injector.map(requiredType).toValue(view);
		}

	}

	function unmapTypeForFilterBinding(filter : ITypeFilter, type : Class<Dynamic>, view : Dynamic) : Void {
		var requiredType : Class<Dynamic>;
		var requiredTypes : Array<Class<Dynamic>> = requiredTypesFor(filter, type);
		for(requiredType in requiredTypes/* AS3HX WARNING could not determine type for var: requiredType exp: EIdent(requiredTypes) type: Array<Class<Dynamic>>*/) {
			if(_injector.satisfiesDirectly(requiredType)) 
				_injector.unmap(requiredType);
		}

	}

	function requiredTypesFor(filter : ITypeFilter, type : Class<Dynamic>) : Array<Class<Dynamic>> {
		var requiredTypes : Array<Class<Dynamic>> = filter.allOfTypes.concat(filter.anyOfTypes);
		if(requiredTypes.indexOf(type) == -1) 
			requiredTypes.push(type);
		return requiredTypes;
	}

	function createRemovedListener(view : Dynamic, type : Class<Dynamic>, processorMappings : Array<Dynamic>) : Void {
		if(Std.is(view, DisplayObject))  {
			Reflect.field(_listenersByView, Std.string(view)) ||= [];
			var handler : Function = function(e : Event) : Void {
				runUnprocessors(view, type, processorMappings);
				(try cast(view, DisplayObject) catch(e:Dynamic) null).removeEventListener(Event.REMOVED_FROM_STAGE, handler);
				removeHandlerFromView(view, handler);
			}
;
			Reflect.field(_listenersByView, Std.string(view)).push(handler);
			(try cast(view, DisplayObject) catch(e:Dynamic) null).addEventListener(Event.REMOVED_FROM_STAGE, handler, false, 0, true);
		}
	}

	function removeHandlerFromView(view : Dynamic, handler : Function) : Void {
		if(Reflect.field(_listenersByView, Std.string(view)) && (Reflect.field(_listenersByView, Std.string(view)).length > 0))  {
			var handlerIndex : Int = Reflect.field(_listenersByView, Std.string(view)).indexOf(handler);
			Reflect.field(_listenersByView, Std.string(view)).splice(handlerIndex, 1);
			if(Reflect.field(_listenersByView, Std.string(view)).length == 0)  {
				This is an intentional compilation error. See the README for handling the delete keyword
				delete Reflect.field(_listenersByView, Std.string(view));
			}
		}
	}

}

