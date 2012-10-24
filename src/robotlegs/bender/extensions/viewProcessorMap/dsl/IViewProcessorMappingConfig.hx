package robotlegs.bender.extensions.viewprocessormap.dsl;

interface IViewProcessorMappingConfig {

	function withGuards() : IViewProcessorMappingConfig;
	function withHooks() : IViewProcessorMappingConfig;
}

