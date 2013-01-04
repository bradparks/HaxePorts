////////////////////////////////////////////////////////////////////////////////
//=BEGIN CLOSED LICENSE
//
// Copyright(c) 2012 Andras Csizmadia.
// http://www.vpmedia.eu
//
// For information about the licensing and copyright please 
// contact Andras Csizmadia at andras@vpmedia.eu.
//
//=END CLOSED LICENSE
////////////////////////////////////////////////////////////////////////////////
package states;

import hu.vpmedia.states.State;
import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

import hu.vpmedia.states.StateMachine;

/**
 * TBD
 */
class StateMachineTest
{    
    private var subject:StateMachine;
    
    public function new() 
    {
        // https://github.com/massiveinteractive/MassiveUnit/wiki/Working-with-test-classes
    }
    
    @Before
    public function setup():Void
    {
        subject = new StateMachine();
        subject.addState(new State("opened", ["closed"]));
        subject.addState(new State("closed", ["opened","locked"]));
        subject.addState(new State("locked", ["closed"]));
        subject.setInitialState("opened");       
    }
    
    @After
    public function tearDown():Void
    {
        subject = null;
    }
    
    @Test
    public function test_instantiate():Void
    {
        Assert.isNotNull(subject);
    }
    
    @Test
    public function test_initialState():Void
    {
        Assert.isNotNull(subject.getState().name == "opened");
    }
    
    @Test
    public function test_canChangeState():Void
    {
        Assert.isFalse(subject.canChangeStateTo("opened"));
        Assert.isFalse(subject.canChangeStateTo("locked"));
        Assert.isTrue(subject.canChangeStateTo("closed"));
    }
    
    @Test
    public function test_changingtToUnexistingState():Void
    {
        Assert.isFalse(subject.changeState("unknown"));
    }
    
    @Test
    public function test_changingtToDeniedState():Void
    {
        Assert.isFalse(subject.changeState("locked"));
    }
    
    @Test
    public function test_changingState():Void
    {
        Assert.isTrue(subject.changeState("closed"));
    }
    
    @Test
    public function test_inAvailStates():Void
    {
        Assert.isTrue(subject.getStates().exists("opened"));
        Assert.isFalse(subject.getStates().exists("unknown"));
    }
}