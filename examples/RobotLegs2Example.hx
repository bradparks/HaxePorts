package;   

import flash.display.Sprite; 
import flash.events.Event; 
import flash.Lib;
import robotlegs.bender.framework.impl.Context;

class RobotLegs2Example extends Sprite 
{
  public var context:Context;
    
  public function new()  
  {
    super();
    Lib.current.addChild(this);
  } 
  
}