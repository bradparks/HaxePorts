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
package;

import flash.display.Bitmap;
import nme.display.BitmapData;
import flash.display.Loader;  
import flash.display.LoaderInfo;
import flash.display.Sprite;
import flash.events.Event;  
import flash.events.IOErrorEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.net.URLRequest;

import hu.vpmedia.display.Reflect;

class ReflectExample extends Sprite {
    private var url:String;
  private var content:Sprite;

    public function new()
  {
        url="bitmap.png";  
        super();               
        flash.Lib.current.addChild(this);
            configureAssets();
    }

    private function configureAssets():Void 
  {
        var loader:Loader=new Loader();
    var info:LoaderInfo = loader.contentLoaderInfo;
        info.addEventListener(Event.COMPLETE, completeHandler);
        info.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);

        var request:URLRequest=new URLRequest(url);
        loader.load(request);
    content = new Sprite();
        content.addChild(loader);  
        addChild(content);
    }

    private function completeHandler(event:Event):Void 
  {          
    var loader:Loader=cast(event.target.loader,Loader);
        
    var image:Bitmap=cast(loader.content,Bitmap); 
     
    var r:Reflect = new Reflect(content, 50, 50, 0, 0, 1);
    }
    
    private function ioErrorHandler(event:IOErrorEvent):Void
  {
        trace("Unable to load image:" + url);
    }
}