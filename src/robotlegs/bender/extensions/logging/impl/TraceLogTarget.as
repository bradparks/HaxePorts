//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.logging.impl
{
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.ILogTarget;
	import robotlegs.bender.framework.api.LogLevel;

	public class TraceLogTarget implements ILogTarget
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private const _messageParser:LogMessageParser = new LogMessageParser();

		private var _context:IContext;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function TraceLogTarget(context:IContext)
		{
			_context = context;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function log(source:Object, level:uint, timestamp:int, message:String, params:Array = null):void
		{
			/*TODO: trace(timestamp // (START + timestamp)
				+ ' ' + LogLevel.NAME[level]
				+ ' ' + _context
				+ ' ' + source
				+ ' - ' + _messageParser.parseMessage(message, params));*/
		}
	}
}
