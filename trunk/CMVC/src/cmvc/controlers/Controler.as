/**
 * @author Mirko Bordjoski http://candymandesign.blogspot.com/
 */ 

package cmvc.controlers
{
	import cmvc.CFacade;
	import cmvc.notificationObjects.CNotification;

	public class Controler implements IControler
	{
		private var _facade:CFacade;
		public function Controler()
		{
		}
		
		public function registerFacade(value:CFacade):void{
			_facade = value;
		}
		
		public function handleNotification(value:CNotification):void{
			
		}
		
		public function sendNotification(notificationName:String, data:Object = null):void{
			facade.procesNotification(notificationName, data);
		}
		
		protected function get facade():CFacade{
			return _facade;
		}
	}
}