/**
 * @author Mirko Bordjoski http://candymandesign.blogspot.com/
 */ 
package cmvc.threading
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * The ThreadingFactory class enables to proces items parallel, reducing the delay between  
	 */ 
	public class ThreadingFactory
	{
		/**
		 * @private
		 */ 
		protected static const THREADING_DELAY:Number = 20;
		
		/**
		 * The ThreadingFactory class enables to proces items parallel, reducing the delay between  
		 */
		public function ThreadingFactory()
		{
		}
		
		/**
		 * 
		 */ 
		public static function procesItems(value:Array, threadingFunction:Function, data:Object = null):void{
			for(var i:int = 0; i < value.length; i++){
				ThreadingFactory.startThread(value[i],threadingFunction,data);
			}
		}
		
		/**
		 * 
		 */ 
		public static function startThread(value:Object, threadingFunction:Function, data:Object = null):void{
			var theValue:Object = value;
			var theThreadingFunction:Function = threadingFunction;
			var theData:Object = data;
			var timer:Timer = new Timer(THREADING_DELAY,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,
									function(e:TimerEvent):void{
										theThreadingFunction(theValue, theData);
									},
									false,0,true);
			timer.start();
		}
	}
}