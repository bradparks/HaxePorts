//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.commandcenter.impl;

import flash.utils.Dictionary;
import robotlegs.bender.extensions.commandcenter.api.ICommandCenter;
import robotlegs.bender.extensions.commandcenter.dsl.ICommandMapper;
import robotlegs.bender.extensions.commandcenter.api.ICommandTrigger;
import robotlegs.bender.extensions.commandcenter.dsl.ICommandUnmapper;

class CommandCenter implements ICommandCenter {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _mappers : Dictionary;
	var NULL_UNMAPPER : ICommandUnmapper;
	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function map(trigger : ICommandTrigger) : ICommandMapper {
		return Reflect.field(_mappers, Std.string(trigger)) ||= new CommandMapper(trigger);
	}

	public function unmap(trigger : ICommandTrigger) : ICommandUnmapper {
		return Reflect.field(_mappers, Std.string(trigger)) || NULL_UNMAPPER;
	}


	public function new() {
		_mappers = new Dictionary();
		NULL_UNMAPPER = new NullCommandUnmapper();
	}
}

