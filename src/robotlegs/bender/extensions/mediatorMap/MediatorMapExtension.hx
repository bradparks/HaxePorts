//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap;

import org.swiftsuspenders.Injector;
import robotlegs.bender.extensions.mediatormap.api.IMediatorFactory;
import robotlegs.bender.extensions.mediatormap.api.IMediatorMap;
import robotlegs.bender.extensions.mediatormap.impl.DefaultMediatorManager;
import robotlegs.bender.extensions.mediatormap.impl.MediatorFactory;
import robotlegs.bender.extensions.mediatormap.impl.MediatorMap;
import robotlegs.bender.extensions.viewmanager.api.IViewHandler;
import robotlegs.bender.extensions.viewmanager.api.IViewManager;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;
import robotlegs.bender.framework.impl.UID;

class MediatorMapExtension implements IExtension {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _uid : String;
	var _injector : Injector;
	var _mediatorMap : IMediatorMap;
	var _viewManager : IViewManager;
	var _mediatorManager : DefaultMediatorManager;
	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function extend(context : IContext) : Void {
		_injector = context.injector;
		_injector.map(IMediatorFactory).toSingleton(MediatorFactory);
		_injector.map(IMediatorMap).toSingleton(MediatorMap);
		context.lifecycle.beforeInitializing(beforeInitializing);
		context.lifecycle.beforeDestroying(beforeDestroying);
		context.lifecycle.whenDestroying(whenDestroying);
	}

	public function toString() : String {
		return _uid;
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function beforeInitializing() : Void {
		_mediatorMap = _injector.getInstance(IMediatorMap);
		_mediatorManager = _injector.getInstance(DefaultMediatorManager);
		if(_injector.satisfiesDirectly(IViewManager))  {
			_viewManager = _injector.getInstance(IViewManager);
			_viewManager.addViewHandler(try cast(_mediatorMap, IViewHandler) catch(e:Dynamic) null);
		}
	}

	function beforeDestroying() : Void {
		var mediatorFactory : IMediatorFactory = _injector.getInstance(IMediatorFactory);
		mediatorFactory.removeAllMediators();
		if(_injector.satisfiesDirectly(IViewManager))  {
			_viewManager = _injector.getInstance(IViewManager);
			_viewManager.removeViewHandler(try cast(_mediatorMap, IViewHandler) catch(e:Dynamic) null);
		}
	}

	function whenDestroying() : Void {
		if(_injector.satisfiesDirectly(IMediatorMap))  {
			_injector.unmap(IMediatorMap);
		}
		if(_injector.satisfiesDirectly(IMediatorFactory))  {
			_injector.unmap(IMediatorFactory);
		}
	}


	public function new() {
		_uid = UID.create(MediatorMapExtension);
	}
}

