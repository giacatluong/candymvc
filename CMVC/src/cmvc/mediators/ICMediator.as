/**
 * @author Mirko Bordjoski http://candymandesign.blogspot.com/
 */ 

package cmvc.mediators
{
	import cmvc.CFacade;
	import cmvc.notificationObjects.CNotification;

	public interface ICMediator
	{
		function registerFacade(value:CFacade):void
		function listNotifications():Array
		function handleNotification(value:CNotification):void;
		function sendNotification(value:String, data:Object = null):void;
		function getName():String
		function get viewComponent():Object
		function onRegister():void
		function onRemove():void
		function initializationComplete():void
		function set filterNotifications(value:Boolean):void
		function get filterNotifications():Boolean
	}
}