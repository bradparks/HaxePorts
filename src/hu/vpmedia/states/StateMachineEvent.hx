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

class StateMachineEvent
{
public static inline var ENTER_CALLBACK:String="stateChangeEnter";
public static inline var EXIT_CALLBACK:String="stateChangeExit";
public static inline var TRANSITION_START:String="stateChangeStart";
public static inline var TRANSITION_COMPLETE:String="stateChangeComplete";
public static inline var TRANSITION_DENIED:String="stateChangeDenied";
public var fromState:String;
public var toState:String;
public var currentState:String;
public var type:String;
public var allowedStates:Array<String>;

public function new(type:String)
{
    this.type=type;
}

public function toString():String
{
    return "[SME] " + type + " :: " + fromState + " => " + currentState + " => " + toState;
}

public function clone():StateMachineEvent
{
    var result:StateMachineEvent=new StateMachineEvent(type);
    result.fromState=fromState;
    result.currentState=currentState;
    result.toState=toState;
    result.allowedStates=[];
    if (allowedStates != null)
    {
        result.allowedStates=allowedStates.copy();
    }
    return result;
}
}