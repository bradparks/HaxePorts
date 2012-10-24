package robotlegs.bender.extensions.viewprocessormap.impl;

import flash.utils.Dictionary;
import robotlegs.bender.extensions.matching.ITypeFilter;
import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorMapper;
import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorMapping;
import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorMappingConfig;
import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorUnmapper;
import robotlegs.bender.extensions.viewprocessormap.impl.IViewProcessorViewHandler;

class ViewProcessorMapper implements IViewProcessorMapper, implements IViewProcessorUnmapper {

	var _handler : IViewProcessorViewHandler;
	var _matcher : ITypeFilter;
	var _mappings : Dictionary;
	public function new(matcher : ITypeFilter, handler : IViewProcessorViewHandler) {
		_mappings = new Dictionary();
		_handler = handler;
		_matcher = matcher;
	}

	//---------------------------------------
		// IViewProcessorMapper Implementation
		//---------------------------------------
		public function toProcess(processClassOrInstance : Dynamic) : IViewProcessorMappingConfig {
		return lockedMappingFor(processClassOrInstance) || createMapping(processClassOrInstance);
	}

	public function toInjection() : IViewProcessorMappingConfig {
		return toProcess(ViewInjectionProcessor);
	}

	public function toNoProcess() : IViewProcessorMappingConfig {
		return toProcess(NullProcessor);
	}

	//---------------------------------------
		// IViewProcessorUnmapper Implementation
		//---------------------------------------
		public function fromProcess(processorClassOrInstance : Dynamic) : Void {
		var mapping : IViewProcessorMapping = Reflect.field(_mappings, Std.string(processorClassOrInstance));
		This is an intentional compilation error. See the README for handling the delete keyword
		delete Reflect.field(_mappings, Std.string(processorClassOrInstance));
		_handler.removeMapping(mapping);
	}

	public function fromProcesses() : Void {
		for(processor in Reflect.fields(_mappings)) {
			fromProcess(processor);
		}

	}

	public function fromNoProcess() : Void {
		fromProcess(NullProcessor);
	}

	public function fromInjection() : Void {
		fromProcess(ViewInjectionProcessor);
	}

	function createMapping(processor : Dynamic) : ViewProcessorMapping {
		var mapping : ViewProcessorMapping = new ViewProcessorMapping(_matcher, processor);
		_handler.addMapping(mapping);
		Reflect.setField(_mappings, Std.string(processor), mapping);
		return mapping;
	}

	function lockedMappingFor(processorClassOrInstance : Dynamic) : ViewProcessorMapping {
		var mapping : ViewProcessorMapping = Reflect.field(_mappings, Std.string(processorClassOrInstance));
		if(mapping != null) 
			mapping.invalidate();
		return mapping;
	}

}

