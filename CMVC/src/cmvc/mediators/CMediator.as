/**
 * @author Mirko Bordjoski http://candymandesign.blogspot.com/
 */ 

package cmvc.mediators
{
	import cmvc.CFacade;
	import cmvc.notificationObjects.CNotification;
	
	public class CMediator implements ICMediator
	{
		private var _filterNotifications:Boolean = true;
		
		private var _name:String;
		private var _viewComponent:Object;
		private var _facade:CFacade;
		
		public function CMediator(name:String, viewComponent:Object = null)
		{
			_name = name;
			_viewComponent = viewComponent;
		}
		
		protected function get facade():CFacade
		{
			return _facade;
		}
		
		public function registerFacade(value:CFacade):void
		{
			_facade = value;
		}
		
		public function listNotifications():Array
		{
			return null;
		}
		
		public function handleNotification(notification:CNotification):void
		{
		}
		
		public function sendNotification(notificationName:String, data:Object = null):void{
			facade.procesNotification(notificationName, data);
		}
		
		public function getName():String{
			return _name;
		}
		
		public function get viewComponent():Object{
			return _viewComponent;
		}
		
		public function onRegister():void{
			
		}
		
		public function onRemove():void{
			
		}
		
		public function initializationComplete():void{
			
		}
		
		public function set filterNotifications(value:Boolean):void{
			_filterNotifications = value;
		}
		
		public function get filterNotifications():Boolean{
			return _filterNotifications;
		}
		
		
	}
}