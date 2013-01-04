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
package hu.vpmedia.states;

import flash.events.Event;
import flash.events.EventDispatcher;
import msignal.Signal;

/*
 * Original AS3 port: https://github.com/cassiozen/AS3-State-Machine (MIT License)
 * Haxe port and modifications (Event -> Signal) by Andras Csizmadia <andras@vpmedia.eu>
 */
class StateMachine
{
    public static var ALL_STATES_ACCEPTED:String="*";
    public var id:String;
    public var signal:Signal1<StateMachineEvent>;
    public var parentState:IState;
    public var parentStates:Array<IState>;
    public var path:Array<Int>;
    
    private var _state:String;
    private var _states:Hash<IState>;
    private var _outEvent:StateMachineEvent;
     
    /**
     * Creates a generic StateMachine. 
     */
    public function new()
    {
        _states=new Hash();
        signal=new Signal1(this);
    }
    
    /**
     * Adds a new state
     * @param stateName    The name of the new State
     * @param stateData    A hash containing state enter and exit callbacks and allowed states to transition from
     * The "from" property can be a string or and array with the state names or * to allow any transition
    **/
    public function addState(state:IState, ?parentName:String = null):Void
    {
        //if(stateName in _states) trace("[StateMachine]",id,"Overriding existing state " + stateName);
                    
        var parentState:IState = null;
        if(parentName != null)
        {
            parentState = _states.get(parentName);
            state.parent = parentState;
        }        
        _states.set(state.name, state );
    }
    
    /**
     * Sets the first state, calls enter callback and dispatches TRANSITION_COMPLETE
     * These will only occour if no state is defined
     * @param stateName    The name of the State
    **/
    public function setInitialState(stateName:String):Void
    {
        if (_state == null && _states.exists(stateName))
        {
            _state=stateName;
            var _callbackEvent:StateMachineEvent=new StateMachineEvent(StateMachineEvent.ENTER_CALLBACK);
            _callbackEvent.toState=stateName;
            if (_states.get(_state).root != null)
            {
                parentStates=_states.get(_state).parents;
                for (j in (parentStates.length - 1)...0)
                {
                    if (parentStates[j].enter != null)
                    {
                        _callbackEvent.currentState=parentStates[j].name;
                        parentStates[j].enter(_callbackEvent);
                    }
                }
            } 
            if (_states.get(_state).enter != null)
            {
                _callbackEvent.currentState=_state;
                _states.get(_state).enter(_callbackEvent);
            }
            _outEvent=new StateMachineEvent(StateMachineEvent.TRANSITION_COMPLETE);
            _outEvent.toState=stateName;
            signal.dispatch(_outEvent);
        }
    }
    
    /**
     *    Getters for the current state and for the Hash of states
     */

    public function getState():IState
    {
        return _states.get(_state);
    }
    
    public function getStateName():String
    {
        return _state;
    }
    
    public function getStates():Hash<IState>
    {
        return _states;
    }
    
    public function getStateByName(name:String):IState
    {
        for (s in _states)
        {
            if (s.name == name)
                return s;
            }
        return null;
    }
    
    /**
     * Verifies if a transition can be made from the current state to the state passed as param
     * @param stateName    The name of the State
    **/
    public function canChangeStateTo(stateName:String):Bool
    {
        var s:IState = _states.get(stateName);
        return (stateName != _state && _states.exists(stateName) && (Lambda.indexOf(s.from,_state) != -1 || s.from[0] == ALL_STATES_ACCEPTED));
    }
    
    /**
     * Discovers the how many "exits" and how many "enters" are there between two
     * given states and returns an array with these two integers
     * @param stateFrom The state to exit
     * @param stateTo The state to enter
    **/
    public function findPath(stateFrom:String, stateTo:String):Array<Int>
    {
        // Verifies if the states are in the same "branch" or have a common parent
        var fromState:IState = null;
        if(stateFrom != null)
        {
            fromState=_states.get(stateFrom);
        }
        var c:Int=0;
        var d:Int=0;
        while (fromState != null)
        {
            d=0;
            var toState:IState=_states.get(stateTo);
            while (toState != null)
            {
                if (fromState == toState)
                {
                    // They are in the same brach or have a common parent Common parent
                    return [c, d];
                }
                d++;
                toState=toState.parent;
            }
            c++;
            fromState=fromState.parent;
        }
        // No direct path, no commom parent: exit until root then enter until element
        return [c, d];
    }
    
    /**
     * Changes the current state
     * This will only be done if the intended state allows the transition from the current state
     * Changing states will call the exit callback for the exiting state and enter callback for the entering state
     * @param stateTo    The name of the state to transition to
    **/
    public function changeState(stateTo:String):Bool
    {
        // If there is no state that maches stateTo
        if (!(_states.exists(stateTo)))
        {
            //trace("[StateMachine]",id,"Cannot make transition: State "+ stateTo +" is not defined");
            _outEvent=new StateMachineEvent(StateMachineEvent.TRANSITION_DENIED);
            _outEvent.fromState=_state;
            _outEvent.toState=stateTo;
            _outEvent.allowedStates=null;
            signal.dispatch(_outEvent);
            return false;
        }
        // If current state is not allowed to make this transition
        if (!canChangeStateTo(stateTo))
        {
            //trace("[StateMachine]",id,"Transition to "+ stateTo +" denied");
            _outEvent=new StateMachineEvent(StateMachineEvent.TRANSITION_DENIED);
            _outEvent.fromState=_state;
            _outEvent.toState=stateTo;
            _outEvent.allowedStates=_states.get(stateTo).from;
            signal.dispatch(_outEvent);
            return false;
        }
        _outEvent=new StateMachineEvent(StateMachineEvent.TRANSITION_START);
        _outEvent.fromState=_state;
        _outEvent.toState=stateTo;
        _outEvent.allowedStates=_states.get(stateTo).from;
        signal.dispatch(_outEvent);
        // call exit and enter callbacks (if they exits)
        path=findPath(_state, stateTo);
        if (path[0] > 0)
        {
            var _exitCallbackEvent:StateMachineEvent=new StateMachineEvent(StateMachineEvent.EXIT_CALLBACK);
            _exitCallbackEvent.toState=stateTo;
            _exitCallbackEvent.fromState=_state;
            if (_states.get(_state).exit != null)
            {
                _exitCallbackEvent.currentState=_state;
                _states.get(_state).exit(_exitCallbackEvent);
            }
            parentState=_states.get(_state);
            for (i in 0...(path[0] - 1))
            {
                parentState=parentState.parent;
                if (parentState.exit != null)
                {
                _exitCallbackEvent.currentState=parentState.name;
                parentState.exit(_exitCallbackEvent);
                }
            }
        }
        var oldState:String=_state;
        _state=stateTo;
        if (path[1] > 0)
        {
            var _enterCallbackEvent:StateMachineEvent=new StateMachineEvent(StateMachineEvent.ENTER_CALLBACK);
            _enterCallbackEvent.toState=stateTo;
            _enterCallbackEvent.fromState=oldState;
            if (_states.get(stateTo).root != null)
            {
                parentStates=_states.get(stateTo).parents;
                var n:Int = path[1] - 2;            
                while (n>=0)
                {
                    if (parentStates[n] != null && parentStates[n].enter != null)
                    {
                        _enterCallbackEvent.currentState=parentStates[n].name;
                        parentStates[n].enter(_enterCallbackEvent);
                    }
                    n--;
                }
            }
            if (_states.get(_state).enter != null)
            {
                _enterCallbackEvent.currentState=_state;
                _states.get(_state).enter(_enterCallbackEvent);
            }
        }
        //trace("[StateMachine]",id,"State Changed to " + _state);
        // Transition is complete. dispatch TRANSITION_COMPLETE
        _outEvent=new StateMachineEvent(StateMachineEvent.TRANSITION_COMPLETE);
        _outEvent.fromState=oldState;
        _outEvent.toState=stateTo;
        signal.dispatch(_outEvent);
        
        return true;
    }
}