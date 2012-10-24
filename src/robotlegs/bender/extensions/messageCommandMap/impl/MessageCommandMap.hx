//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.messagecommandmap.impl;

import flash.utils.Dictionary;
import org.swiftsuspenders.Injector;
import robotlegs.bender.framework.api.IMessageDispatcher;
import robotlegs.bender.extensions.commandcenter.api.ICommandCenter;
import robotlegs.bender.extensions.commandcenter.api.ICommandTrigger;
import robotlegs.bender.extensions.commandcenter.dsl.ICommandMapper;
import robotlegs.bender.extensions.commandcenter.dsl.ICommandUnmapper;
import robotlegs.bender.extensions.messagecommandmap.api.IMessageCommandMap;

class MessageCommandMap implements IMessageCommandMap {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _triggers : Dictionary;
	var _injector : Injector;
	var _dispatcher : IMessageDispatcher;
	var _commandCenter : ICommandCenter;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(injector : Injector, dispatcher : IMessageDispatcher, commandCenter : ICommandCenter) {
		_triggers = new Dictionary();
		_injector = injector;
		_dispatcher = dispatcher;
		_commandCenter = commandCenter;
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function map(message : Dynamic) : ICommandMapper {
		var trigger : ICommandTrigger = Reflect.field(_triggers, Std.string(message)) ||= createTrigger(message);
		return _commandCenter.map(trigger);
	}

	public function unmap(message : Dynamic) : ICommandUnmapper {
		return _commandCenter.unmap(getTrigger(message));
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function createTrigger(message : Dynamic) : ICommandTrigger {
		return new MessageCommandTrigger(_injector, _dispatcher, message);
	}

	function getTrigger(message : Dynamic) : ICommandTrigger {
		return Reflect.field(_triggers, Std.string(message));
	}

}

