package robotlegs.bender.extensions.viewprocessormap.impl;

import org.swiftsuspenders.Injector;
import flash.utils.Dictionary;
import flash.events.IEventDispatcher;

class ViewInjectionProcessor {

	var _injectedObjects : Dictionary;
	public function process(view : Dynamic, type : Class<Dynamic>, injector : Injector) : Void {
		Reflect.field(_injectedObjects, Std.string(view)) || injectAndRemember(view, injector);
	}

	public function unprocess(view : Dynamic, type : Class<Dynamic>, injector : Injector) : Void {
	}

	function injectAndRemember(view : Dynamic, injector : Injector) : Void {
		injector.injectInto(view);
		Reflect.setField(_injectedObjects, Std.string(view), view);
	}


	public function new() {
		_injectedObjects = new Dictionary(true);
	}
}

