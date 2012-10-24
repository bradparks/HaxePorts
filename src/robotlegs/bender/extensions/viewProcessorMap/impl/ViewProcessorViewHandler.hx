//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewprocessormap.impl;

import flash.utils.Dictionary;
import robotlegs.bender.extensions.matching.ITypeFilter;
import flash.display.DisplayObject;
import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorMapping;

class ViewProcessorViewHandler implements IViewProcessorViewHandler {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _mappings : Array<Dynamic>;
	var _knownMappings : Dictionary;
	var _factory : IViewProcessorFactory;
	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function new(factory : IViewProcessorFactory) {
		_mappings = [];
		_knownMappings = new Dictionary(true);
		_factory = factory;
	}

	public function addMapping(mapping : IViewProcessorMapping) : Void {
		var index : Int = _mappings.indexOf(mapping);
		if(index > -1) 
			return;
		_mappings.push(mapping);
		flushCache();
	}

	public function removeMapping(mapping : IViewProcessorMapping) : Void {
		var index : Int = _mappings.indexOf(mapping);
		if(index == -1) 
			return;
		_mappings.splice(index, 1);
		flushCache();
	}

	public function processItem(item : Dynamic, type : Class<Dynamic>) : Void {
		var interestedMappings : Array<Dynamic> = getInterestedMappingsFor(item, type);
		if(interestedMappings != null) 
			_factory.runProcessors(item, type, interestedMappings);
	}

	public function unprocessItem(item : Dynamic, type : Class<Dynamic>) : Void {
		var interestedMappings : Array<Dynamic> = getInterestedMappingsFor(item, type);
		if(interestedMappings != null) 
			_factory.runUnprocessors(item, type, interestedMappings);
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function flushCache() : Void {
		_knownMappings = new Dictionary(true);
	}

	function getInterestedMappingsFor(view : Dynamic, type : Class<Dynamic>) : Array<Dynamic> {
		var mapping : IViewProcessorMapping;
		// we've seen this type before and nobody was interested
		if(Reflect.field(_knownMappings, Std.string(type)) == false) 
			return null;
		// we haven't seen this type before
		if(Reflect.field(_knownMappings, Std.string(type)) == null)  {
			Reflect.setField(_knownMappings, Std.string(type), false);
			for(mapping in _mappings/* AS3HX WARNING could not determine type for var: mapping exp: EIdent(_mappings) type: Array<Dynamic>*/) {
				mapping.validate();
				if(mapping.matcher.matches(view))  {
					Reflect.field(_knownMappings, Std.string(type)) ||= [];
					Reflect.field(_knownMappings, Std.string(type)).push(mapping);
				}
			}

			// nobody cares, let's get out of here
			if(Reflect.field(_knownMappings, Std.string(type)) == false) 
				return null;
		}
;
		// these mappings really do care
		return try cast(Reflect.field(_knownMappings, Std.string(type)), Array) catch(e:Dynamic) null;
	}

}

