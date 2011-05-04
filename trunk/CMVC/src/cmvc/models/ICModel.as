/**
 * @author Mirko Bordjoski http://candymandesign.blogspot.com/
 */ 

package cmvc.models
{
	import cmvc.CFacade;

	public interface ICModel
	{
		/**
		 * @private
		 * When registering ICModel in facade, this method is called internaly.
		 */ 
		function registerFacade(value:CFacade):void
			
		/**
		 * This method is called as soon as ICModel is added to CFacade.
		 */ 
		function onRegister():void
			
		/**
		 * This method is called as soon as ICModel is removed from CFacade.
		 */ 
		function onRemove():void
			
			
		/**
		 * Send notification to subscribed items.
		 */ 
		function sendNotification(value:String, data:Object = null):void;
		
		/**
		 * This method is called after initialization has finished, after calling start() method from facade
		 */ 
		function initializationComplete():void
			
			
		/**
		 * Get the name of ICModel
		 */ 
		function getName():String
	}
}