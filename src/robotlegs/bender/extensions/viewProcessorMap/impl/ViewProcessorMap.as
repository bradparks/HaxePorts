package robotlegs.bender.extensions.viewProcessorMap.impl
{
	import robotlegs.bender.extensions.viewProcessorMap.api.IViewProcessorMap;
	import robotlegs.bender.extensions.viewManager.api.IViewHandler;
	import robotlegs.bender.extensions.viewProcessorMap.dsl.IViewProcessorMapper;
	import robotlegs.bender.extensions.viewProcessorMap.dsl.IViewProcessorUnmapper;
	import flash.display.DisplayObject;
	import robotlegs.bender.extensions.matching.ITypeMatcher;
	import robotlegs.bender.extensions.viewProcessorMap.impl.ViewProcessorMapping;
	import robotlegs.bender.extensions.matching.TypeMatcher;
	import flash.utils.Dictionary;
	import robotlegs.bender.extensions.viewProcessorMap.impl.NullViewProcessorUnmapper;

	public class ViewProcessorMap implements IViewProcessorMap, IViewHandler
	{
		private const _mappers:Dictionary = new Dictionary();
		
		private var _factory:IViewProcessorFactory;
		
		private var _handler:IViewProcessorViewHandler;
		
		private const NULL_UNMAPPER:IViewProcessorUnmapper = new NullViewProcessorUnmapper();
		
		public function ViewProcessorMap(factory:ViewProcessorFactory, handler:ViewProcessorViewHandler = null)
		{
			_factory = factory;
			_handler = handler || new ViewProcessorViewHandler(_factory); 
		}

		//---------------------------------------
		// IViewProcessorMap Implementation
		//---------------------------------------

		public function mapMatcher(matcher:ITypeMatcher):IViewProcessorMapper
		{
			return _mappers[matcher.createTypeFilter().descriptor] ||= createMapper(matcher);
		}

		public function map(type:Class):IViewProcessorMapper
		{
			const matcher:ITypeMatcher = new TypeMatcher().allOf(type);
			return mapMatcher(matcher);
		}
		
		public function unmapMatcher(matcher:ITypeMatcher):IViewProcessorUnmapper
		{
			return _mappers[matcher.createTypeFilter().descriptor] || NULL_UNMAPPER;
		}

		public function unmap(type:Class):IViewProcessorUnmapper
		{
			const matcher:ITypeMatcher = new TypeMatcher().allOf(type);
			return unmapMatcher(matcher);
		}

		public function process(item:Object):void
		{
			const type:Class = item.constructor as Class;
			_handler.processItem(item, type);
		}

		public function unprocess(item:Object):void
		{
			const type:Class = item.constructor as Class;
			_handler.unprocessItem(item, type);
		}

		//---------------------------------------
		// IViewHandler Implementation
		//---------------------------------------

		public function handleView(view:DisplayObject, type:Class):void
		{
			_handler.processItem(view, type);
		}
		
		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/
		
		private function createMapper(matcher:ITypeMatcher, viewType:Class = null):IViewProcessorMapper
		{
			return new ViewProcessorMapper(matcher.createTypeFilter(), _handler);
		}
		
	
	}

}