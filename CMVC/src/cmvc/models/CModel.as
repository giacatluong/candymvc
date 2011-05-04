/**
 * @author Mirko Bordjoski http://candymandesign.blogspot.com/
 */ 

package cmvc.models
{
	import cmvc.CFacade;
	
	/**
	 * CModel is where the logical things happen
	 */ 
	public class CModel implements ICModel
	{
		private var _facade:CFacade;
		private var _name:String;
		private var _data:Object;
		
		
		/**
		 * CModel is where the logical things happen
		 */
		public function CModel(name:String, data:Object = null)
		{
			_name = name;
			_data = data;
		}
		
		public function registerFacade(value:CFacade):void
		{
			_facade = value;
		}
		
		public function onRegister():void
		{
		}
		
		public function onRemove():void
		{
		}
		
		public function sendNotification(value:String, data:Object = null):void{
			facade.procesNotification(value,data);
		}
		
		public function initializationComplete():void{
			
		}
		
		protected function get facade():CFacade{
			return _facade;
		}
		
		public function getName():String{
			return _name;
		}
		
		public function getData():Object{
			return _data;
		}
	}
}