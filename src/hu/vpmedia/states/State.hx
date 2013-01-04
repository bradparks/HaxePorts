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

class State implements IState
{
    public var name:String;
    public var from:Array<String>;
    public var enter:StateMachineEvent->Void;
    public var exit:StateMachineEvent->Void;
    public var children:Array<IState>;
    public var parent(getParent, setParent):IState;
    public var root(getRoot, null):IState;
    public var parents(getParents, null):Array<IState>;
    private var _parent:IState;
    public function new(name:String, from:Array<String>=null, enter:StateMachineEvent->Void=null, exit:StateMachineEvent->Void=null)
    {
        this.name=name;
        if (from==null)
        from=["*"];
        this.from=from;
        this.enter=enter;
        this.exit=exit;
        this.children=[];
        /*if (parent != null)
        {
            _parent=parent;
            _parent.children.push(this);
        }*/
    }
    
    /*public function isAllowTransitionFrom(stateName:String):Bool
    {
        return(from.indexOf(stateName)!=-1 || from.indexOf("*"));
    }*/
    
    function setParent(parent:IState):IState
    {
        _parent=parent;
        _parent.children.push(this);
        return _parent;
    }
    
    function getParent():IState
    {
        return _parent;
    }
    
    function getRoot():IState
    {
        var parentState:IState=_parent;
        if (parentState != null)
        {
            while (parentState.parent != null)
            {
                parentState=parentState.parent;
            }
        }
        return parentState;
    }
    
    function getParents():Array<IState>
    {
        var parentList:Array<IState>=[];
        var parentState:IState=_parent;
        if (parentState != null)
        {
            parentList.push(parentState);
            while (parentState.parent != null)
            {
                parentState=parentState.parent;
                parentList.push(parentState);
            }
        }
        return parentList;
    }
    
    public function toString():String
    {
        return this.name;
    }
}