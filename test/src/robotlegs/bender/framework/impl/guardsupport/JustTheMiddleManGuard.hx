//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl.guardsupport;

class JustTheMiddleManGuard {

	@:meta(Inject())
	public var bossDecision : BossGuard;
	public function approve() : Bool {
		return bossDecision.approve();
	}


	public function new() {
	}
}

