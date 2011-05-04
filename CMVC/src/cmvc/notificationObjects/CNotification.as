/**
 * @author Mirko Bordjoski http://candymandesign.blogspot.com/
 */ 

package cmvc.notificationObjects
{
	/**
	 * CNotification class represents Value Object that is processed by all subscribed ICMedaitors or IControlers.
	 */ 
	public class CNotification extends Object
	{
		/**
		 * The name of notification.
		 */ 
		public var name:String;
		
		/**
		 * Data sent through notification.
		 */ 
		public var data:Object;
		
		
		/**
		 * CNotification class represents Value Object that is processed by all subscribed ICMedaitors or IControlers.
		 * 
		 * @param name The name of notification.
		 * @param data Data sent through notification.
		 */ 
		public function CNotification(name:String, data:Object = null)
		{
			super();
			this.name = name;
			this.data = data;
		}
		
		/**
		 * Convert the object to String
		 */ 
		public function toString():String{
			return "CNotification {NAME: " + this.name + ", DATA: " + String(data) + "} ";
		}
	}
}