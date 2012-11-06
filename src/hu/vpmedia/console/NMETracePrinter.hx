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
package hu.vpmedia.console;

import haxe.PosInfos;

/**
A ConsolePrinter that raises an alert for each log message.
*/
class NMETracePrinter implements mconsole.Printer
{
    public function new()
    {        
    }
    
    public function print(level:mconsole.LogLevel, params:Array<Dynamic>, indent:Int, pos:PosInfos):Void
    {
        flash.Lib.trace(Std.string(level) + "@" + pos.className + "." + pos.methodName + ":" + params.join(", "));
    }
}