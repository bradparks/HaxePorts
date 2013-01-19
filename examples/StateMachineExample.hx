////////////////////////////////////////////////////////////////////////////////
//=BEGIN LICENSE MIT
//
// Copyright (c) 2012, Original author & contributors
// Original author : Cássio S. Antonio
// Contributors: Andras Csizmadia <andras@vpmedia.eu> 
// 
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//  
//=END LICENSE MIT
////////////////////////////////////////////////////////////////////////////////

package;

import flash.display.Sprite;
import hu.vpmedia.states.State;
import hu.vpmedia.states.StateMachine;
import hu.vpmedia.states.StateMachineEvent;


class StateMachineExample extends Sprite 
{        
    private var subject:StateMachine;
    
    public function new()
    {
        super();
        initialize();
    }
    
    public function initialize():Void
    {
        trace(this+"::"+"initialize");
                
        subject = new StateMachine();
        subject.signal.add(stateMachineHandler);
        subject.addState(new State("stateA", ["*"], stateHandlerA, stateHandlerA));
        subject.addState(new State("stateB", ["stateA"], stateHandlerB, stateHandlerB));
        subject.addState(new State("stateC", ["stateA"], stateHandlerC, stateHandlerC)); 
        subject.addState(new State("stateAB", null, stateHandlerAB, stateHandlerAB), "stateA"); 
        subject.addState(new State("stateABC", null, stateHandlerABC, stateHandlerABC), "stateAB");
        subject.changeState("stateA");//accept
        subject.changeState("stateB");//accept
        subject.changeState("stateC");//deny
        subject.changeState("stateA");//accept 
        subject.changeState("stateC");//accept  
        subject.changeState("stateABC");//accept
    } 
    
    private function stateMachineHandler(event:StateMachineEvent):Void
    {
       trace(this+"::stateMachineHandler::"+event.type+"::"+event.fromState+"=>"+event.currentState+"=>"+event.toState);
    } 
    
    private function stateHandlerA(event:StateMachineEvent):Void
    {
       trace(this+"::stateHandlerA::"+event.type+"::"+event.fromState+"=>"+event.currentState+"=>"+event.toState);
    }
    
    private function stateHandlerB(event:StateMachineEvent):Void
    {
       trace(this+"::stateHandlerB::"+event.type+"::"+event.fromState+"=>"+event.currentState+"=>"+event.toState);
    }
    
    private function stateHandlerC(event:StateMachineEvent):Void
    {
       trace(this+"::stateHandlerC::"+event.type+"::"+event.fromState+"=>"+event.currentState+"=>"+event.toState);
    }  
    
    private function stateHandlerAB(event:StateMachineEvent):Void
    {
       trace(this+"::stateHandlerAB::"+event.type+"::"+event.fromState+"=>"+event.currentState+"=>"+event.toState);
    } 
    
    private function stateHandlerABC(event:StateMachineEvent):Void
    {
       trace(this+"::stateHandlerABC::"+event.type+"::"+event.fromState+"=>"+event.currentState+"=>"+event.toState);
    }
    
}
