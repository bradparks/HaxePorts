//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.eventcommandmap.impl;

import org.swiftsuspenders.Injector;
import robotlegs.bender.extensions.commandcenter.api.ICommandMapping;
import robotlegs.bender.framework.impl.ApplyHooks;
import robotlegs.bender.framework.impl.GuardsApprove;

class EventCommandFactory {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _injector : Injector;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(injector : Injector) {
		_injector = injector;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function create(mapping : ICommandMapping) : Dynamic {
		if(guardsApprove(mapping.guards, _injector))  {
			var commandClass : Class<Dynamic> = mapping.commandClass;
			_injector.map(commandClass).asSingleton();
			var command : Dynamic = _injector.getInstance(commandClass);
			applyHooks(mapping.hooks, _injector);
			_injector.unmap(commandClass);
			return command;
		}
		return null;
	}

}

