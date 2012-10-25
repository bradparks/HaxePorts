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
import flash.display.BitmapData;
import flash.display.Loader;  
import flash.display.LoaderInfo;
import flash.display.Sprite;
import flash.events.Event;  
import flash.events.IOErrorEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.net.URLRequest;

import nme.Assets;
 
import org.bytearray.display.ScaleBitmap;

class ScaleBitmapExample extends Sprite {
    private var url:String;

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
        addChild(loader);
    }

    private function completeHandler(event:Event):Void 
    {          
        var loader:Loader=cast(event.target.loader,Loader);
            
        var image:Bitmap=cast(loader.content,Bitmap); 
        
        var bitmapData:BitmapData=image.bitmapData;
        initBitmapData(bitmapData);        
    }
    
    private function ioErrorHandler(event:IOErrorEvent):Void
    {
        trace("Unable to load image:" + url);
        
        var image:BitmapData = Assets.getBitmapData("images/bitmap.png"); 
        initBitmapData(image);
    }
    
    private function initBitmapData(bitmapData:BitmapData):Void
    {
        var b:ScaleBitmap = new ScaleBitmap(bitmapData.clone());
        addChild(b);
        b.x = b.y = 200;
        b.bitmapScale9Grid = new Rectangle(20, 20, 80, 80);
        b.bitmapWidth = 400;
        b.bitmapHeight = 200;
    }
}