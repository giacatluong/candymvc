/**
 * @author Mirko Bordjoski http://candymandesign.blogspot.com/
 */ 

package cmvc.controlers
{
	import cmvc.CFacade;
	import cmvc.notificationObjects.CNotification;

	public interface IControler
	{
		/**
		 * @private
		 * When registering ICModel in facade, this method is called internaly.
		 */ 
		function registerFacade(value:CFacade):void
			
		/**
		 * Handle recieved notification
		 */ 
		function handleNotification(value:CNotification):void
			
		/**
		 * Send notification to subscribed items.
		 */ 
		function sendNotification(notificationName:String,data:Object = null):void
	}
}