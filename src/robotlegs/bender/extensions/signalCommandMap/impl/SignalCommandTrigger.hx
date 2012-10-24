//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.signalcommandmap.impl;

import flash.utils.Dictionary;
import flash.utils.DescribeType;
import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;
import org.swiftsuspenders.Injector;
import robotlegs.bender.extensions.commandcenter.api.ICommandMapping;
import robotlegs.bender.extensions.commandcenter.api.ICommandTrigger;
import robotlegs.bender.framework.impl.ApplyHooks;
import robotlegs.bender.framework.impl.GuardsApprove;

class SignalCommandTrigger implements ICommandTrigger {

	/*============================================================================*/	/* Private Properties                                                         */	/*============================================================================*/	var _mappings : Array<ICommandMapping>;
	var _signal : ISignal;
	var _signalClass : Class<Dynamic>;
	var _once : Bool;
	/*============================================================================*/	/* Protected Properties                                                         */	/*============================================================================*/	var _injector : Injector;
	var _signalMap : Dictionary;
	var _verifiedCommandClasses : Dictionary;
	/*============================================================================*/	/* Constructor                                                                */	/*============================================================================*/	public function new(injector : Injector, signalClass : Class<Dynamic>, once : Bool = false) {
		_mappings = new Array<ICommandMapping>();
		_injector = injector;
		_signalClass = signalClass;
		_once = once;
		_signalMap = new Dictionary(false);
		_verifiedCommandClasses = new Dictionary(false);
	}

	/*============================================================================*/	/* Public Functions                                                           */	/*============================================================================*/	public function addMapping(mapping : ICommandMapping) : Void {
		verifyCommandClass(mapping);
		_mappings.push(mapping);
		if(_mappings.length == 1) 
			addSignal(mapping.commandClass);
	}

	public function removeMapping(mapping : ICommandMapping) : Void {
		var index : Int = _mappings.indexOf(mapping);
		if(index != -1)  {
			_mappings.splice(index, 1);
			if(_mappings.length == 0) 
				removeSignal(mapping.commandClass);
		}
	}

	/*============================================================================*/	/* Protected Functions                                                          */	/*============================================================================*/	function verifyCommandClass(mapping : ICommandMapping) : Void {
		if(_verifiedCommandClasses[mapping.commandClass]) 
			return;
		/*TODO:if (describeType(mapping.commandClass).factory.method.(@name == "execute").length() == 0)
            throw new Error("Command Class must expose an execute method");*/_verifiedCommandClasses[mapping.commandClass] = true;
	}

	function routeSignalToCommand(signal : ISignal, valueObjects : Array<Dynamic>, commandClass : Class<Dynamic>, oneshot : Bool) : Void {
		var mappings : Array<ICommandMapping> = _mappings.concat();
		for(mapping in mappings/* AS3HX WARNING could not determine type for var: mapping exp: EIdent(mappings) type: Array<ICommandMapping>*/) {
			if(guardsApprove(mapping.guards, _injector))  {
				_once && removeMapping(mapping);
				_injector.map(mapping.commandClass).asSingleton();
				var command : Dynamic = createCommandInstance(signal.valueClasses, valueObjects, mapping.commandClass);
				applyHooks(mapping.hooks, _injector);
				_injector.unmap(mapping.commandClass);
				command.execute();
				unmapSignalValues(signal.valueClasses, valueObjects);
			}
		}

		if(_once) 
			removeSignal(commandClass);
	}

	function mapSignalValues(valueClasses : Array<Dynamic>, valueObjects : Array<Dynamic>) : Void {
		var i : Int = 0;
		while(i < valueClasses.length) {
			_injector.map(valueClasses[i]).toValue(valueObjects[i]);
			i++;
		}
	}

	function unmapSignalValues(valueClasses : Array<Dynamic>, valueObjects : Array<Dynamic>) : Void {
		var i : Int = 0;
		while(i < valueClasses.length) {
			_injector.unmap(valueClasses[i]);
			i++;
		}
	}

	function createCommandInstance(valueClasses : Array<Dynamic>, valueObjects : Array<Dynamic>, commandClass : Class<Dynamic>) : Dynamic {
		mapSignalValues(valueClasses, valueObjects);
		return _injector.getInstance(commandClass);
	}

	function hasSignalCommand(signal : ISignal, commandClass : Class<Dynamic>) : Bool {
		var callbacksByCommandClass : Dictionary = Reflect.field(_signalMap, Std.string(signal));
		if(callbacksByCommandClass == null) 
			return false;
		var callback : Dynamic->Dynamic = Reflect.field(callbacksByCommandClass, Std.string(commandClass));
		return callback != null;
	}

	/*============================================================================*/	/* Private Functions                                                          */	/*============================================================================*/	function addSignal(commandClass : Class<Dynamic>) : Void {
		if(hasSignalCommand(_signal, commandClass)) 
			return;
		_signal = _injector.getInstance(_signalClass);
		_injector.map(_signalClass).toValue(_signal);
		var signalCommandMap : Dictionary = Reflect.field(_signalMap, Std.string(_signal)) ||= new Dictionary(false);
		var callback : Dynamic->Dynamic = function() : Void {
			routeSignalToCommand(_signal, arguments, commandClass, _once);
		}
;
		Reflect.setField(signalCommandMap, Std.string(commandClass), callback);
		_signal.add(callback);
	}

	function removeSignal(commandClass : Class<Dynamic>) : Void {
		var callbacksByCommandClass : Dictionary = Reflect.field(_signalMap, Std.string(_signal));
		if(callbacksByCommandClass == null) 
			return;
		var callback : Dynamic->Dynamic = Reflect.field(callbacksByCommandClass, Std.string(commandClass));
		if(callback == null) 
			return;
		_signal.remove(callback);
		This is an intentional compilation error. See the README for handling the delete keyword
		delete Reflect.field(callbacksByCommandClass, Std.string(commandClass));
	}

}

