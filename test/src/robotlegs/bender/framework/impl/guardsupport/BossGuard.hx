//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl.guardsupport;

class BossGuard {

	var _approve : Bool;
	public function new(approve : Bool) {
		_approve = approve;
	}

	public function approve() : Bool {
		return _approve;
	}

}

