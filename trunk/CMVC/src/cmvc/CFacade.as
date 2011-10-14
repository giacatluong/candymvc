/**
 * @author Mirko Bordjoski http://candymandesign.blogspot.com/
 */ 

package cmvc
{
	import cmvc.controlers.Controler;
	import cmvc.controlers.IControler;
	import cmvc.mediators.CMediator;
	import cmvc.mediators.ICMediator;
	import cmvc.models.CModel;
	import cmvc.models.ICModel;
	import cmvc.notificationObjects.CNotification;
	import cmvc.threading.ThreadingFactory;
	
	import flash.events.Event;
	
	

	/**
	 * The CFacade class is the brain of operation.
	 */ 
	public class CFacade
	{
		
		
		////////////////////////////// CONSTANTS //////////////////////////////////
		
		/**
		 * Current version of CMVC library
		 */ 
		public static const VERSION:String = "0.9";
			
		
		/**
		 * @private
		 * Pre-defined notification name for initialization
		 */ 
		protected static const START_NOTIFICATION:String = "startNotification";
		
		
		
		///////////////////////////// PUBLIC VARIALBLES /////////////////////////////
		
		
		/**
		 * If value is true, notificaiton will be handled by all subscribed mediators in the same time in parallel
		 */ 
		public var useMultyThreading:Boolean = false;
		
		
		/**
		 * If value is true, system will check which mediator is subscribed before transgering notification.
		 * If value is false, all mediators will get notificaiton with out checking subscription
		 */ 
		public var filterNotifications:Boolean = true;
		
		
		
		//////////////////////////// PRIVATE VARIALBLES /////////////////////////////
		/**
		 * @private
		 */ 
		private var _registeredCMediators:Array;
		
		/**
		 * @private
		 */ 
		private var _registeredCModels:Array;
		
		/**
		 * @private
		 */ 
		private var _registeredControlers:Array;
		
		
		//////////////////////////// PUBLIC METHODS /////////////////////////////////
		
		/**
		 * The CFacade class is the brain of operation.
		 */ 
		public function CFacade()
		{		
		}
		
		
		/**
		 * Start CMVC.
		 * 
		 * @param value Usually instance of application
		 */ 
		public function start(value:Object = null):void{
			initialize();
			var notification:CNotification = new CNotification(START_NOTIFICATION,value);
			if(registeredControlers[START_NOTIFICATION] != null){
				var control:Controler = registeredControlers[START_NOTIFICATION];
				control.handleNotification(notification);
			}
			initializationComplete();
		}
		
		
		/**
		 * Register new mediator.
		 */ 
		public function registerCMediator(value:ICMediator):void{
			if(!hasMediator(value)){
				value.registerFacade(this);
				registeredCMediators.push(value);
				value.onRegister();
			}
		}
		
		/**
		 * Unregister mediator.
		 */ 
		public function removeMediator(mediatorName:String):void{
			for(var i:int = 0; i < registeredCMediators.length; i++){
				var m:CMediator = registeredCMediators[i];
				if(m == null)return;
				if(m.getName() == mediatorName){
					m.registerFacade(null);
					delete registeredCMediators[i];
					m.onRemove();
				}
			}
		}
		
		/**
		 * Retrieve mediator
		 */ 
		public function retrieveMediator(mediatorName:String):ICMediator{
			for(var i:int = 0; i < registeredCMediators.length; i++){
				var m:CMediator = registeredCMediators[i];
				if(m == null)return null;
				if(m.getName() == mediatorName){
					return m;
				}
			}
			return null;
		}
		
		/**
		 * Register new model.
		 */ 
		public function registerModel(value:ICModel):void{
			if(!hasModel(value)){
				value.registerFacade(this);
				registeredModels.push(value);
				value.onRegister();
			}
		}
		
		/**
		 * Removes the model.
		 */ 
		public function removeModel(name:String):void{
			for(var i:int = 0; i < registeredModels.length; i++){
				var m:CModel = registeredModels[i];
				if(m == null)return;
				if(m.getName() == name){
					m.registerFacade(null);
					delete registeredModels[i];
					m.onRemove();
				}
			}
		}
		
		/**
		 * Retrieve model
		 */ 
		public function retrieveModel(modelName:String):ICModel{
			for(var i:int = 0; i < registeredModels.length; i++){
				var m:ICModel = registeredModels[i];
				if(m == null)return null;
				if(m.getName() == modelName){
					return m;
				}
			}
			return null;
		}
		
		
		/**
		 * Register controler with specific notification name
		 */ 
		public function registerControler(notificationName:String, controler:IControler):void{
			controler.registerFacade(this);
			registeredControlers[notificationName] = controler;
		}
		
		/**
		 * Removes controler subscribed with specific notification name
		 */ 
		public function removeControler(notificationName:String):void{
			var cnt:Controler = registeredControlers[notificationName];
			if(cnt == null)return;
			cnt.registerFacade(null);
			cnt = null;
			registeredControlers[notificationName] = null;
		}
		
		
		
		
		
		/**
		 * Set startup controler that will handle startup notificaiton as soon start method is called.
		 */ 
		public function setStartupControler(value:IControler):void{
			registerControler(START_NOTIFICATION,value);
		}
		
		
		
		/**
		 * @private
		 * [For internal use only]
		 * Used to proces notification adter calling sendNotification method from Medaitors or Models
		 */ 
		public function procesNotification(name:String, data:Object):void{
			var notification:CNotification = new CNotification(name,data);			
			procesControlers(notification);
			if(!useMultyThreading)
				procesMediators(notification);
			else
				procesThreadingNotification(notification);
		}
		
		
		
		
		
		
		//////////////////////////// PROTECTED METHODS /////////////////////////////////
		
		
		
		/**
		 * Override this method to initialize StartupControler. 
		 */ 
		protected function initialize():void{
			
		}
		
				
		
		/**
		 * @private
		 * Handle notificaton by subscribed controler.
		 */ 
		protected function procesControlers(value:CNotification):void{
			if(registeredControlers[value.name] != null){
				var control:Controler = registeredControlers[value.name];
				control.handleNotification(value);
			}
		}
		
		
		/**
		 * @private
		 * Handle notification by subscribed mediators.
		 */
		protected function procesMediators(value:CNotification):void{
			for(var i:int = 0; i < registeredCMediators.length; i++){
				var m:ICMediator = registeredCMediators[i];
				procesSignleMediator(m,value);
			}			
		}
		
		/**
		 * @private
		 * Proces notification by subscribed mediator.
		 **/ 
		protected function procesSignleMediator(m:ICMediator, notification:CNotification):void{
			if(filterNotifications){
				if(m.filterNotifications){
					for each(var s:String in m.listNotifications()){
						if(s == notification.name){
							m.handleNotification(notification);
						}
					}
				}
				else{
					m.handleNotification(notification);
				}
			}
			else{
				m.handleNotification(notification);
			}
		}
		
		
		/**
		 * @private
		 * After initializing StartupControl, let know all mediators about that.
		 */
		protected function initializationComplete():void{
			if(!useMultyThreading){
				for each(var m:ICMediator in registeredCMediators){
					m.initializationComplete();
				}
				for each(var mo:ICModel in registeredModels){
					mo.initializationComplete();
				}
			}
			else{
				initializationThreadingProces(registeredCMediators);
				initializationThreadingProces(registeredModels);
			}
		}
		
		
		
		/**
		 * Check if there is already registered mediator by its name
		 */ 
		protected function hasMediator(value:ICMediator):Boolean{
			for(var i:int = 0; i < registeredCMediators.length; i++){
				var m:CMediator = registeredCMediators[i];
				if(m == null)return false;
				if(m.getName() == value.getName()){
					return true;
				}
			}
			return false;
		}
		
		
		
		/**
		 * Check if there is already registered model by its name
		 */ 
		protected function hasModel(value:ICModel):Boolean{
			for(var i:int = 0; i < registeredModels.length; i++){
				var m:CModel = registeredModels[i];
				if(m == null)return false;
				if(m.getName() == value.getName())
					return true;
			}
			return false;
		}
		
		
		
		
		/**
		 * Get all registerd medaitors
		 */ 
		protected function get registeredCMediators():Array{
			if(_registeredCMediators == null)
				_registeredCMediators = new Array();
			return _registeredCMediators;
		}
		
		
		/**
		 * Get all registerd controlers
		 */ 
		protected function get registeredControlers():Array{
			if(_registeredControlers == null)
				_registeredControlers = new Array();
			return _registeredControlers;
		}
		
		
		/**
		 * Get all registerd models
		 */
		protected function get registeredModels():Array{
			if(_registeredCModels == null){
				_registeredCModels = new Array();
			}
			return _registeredCModels;
		}
		
		
		
		
		//////////////////////////// PRIVATE METHODS /////////////////////////////////
		
		
		
		/**
		 * @private
		 * Handle notification by all mediators in the same time.
		 * 
		 * @param value CNotificaiton
		 */ 
		private function procesThreadingNotification(value:CNotification):void{
			ThreadingFactory.procesItems(registeredCMediators,procesThreading,value);
		}
		
		/**
		 * @private
		 * Handle notification by mediator after calling procesThreadingNotification method
		 */ 
		private function procesThreading(value:Object, theNotification:Object):void{
			procesSignleMediator(value as ICMediator, theNotification as CNotification);
		}
		
		
		/**
		 * @private
		 * Handle initialization process by all subscribers in the same time
		 */ 
		private function initializationThreadingProces(value:Array):void{
			ThreadingFactory.procesItems(value, procesInitializationThreading);
		}
		
		/**
		 * @private
		 * Call initializationComplete after threading process.
		 */ 
		private function procesInitializationThreading(value:Object, theData:Object):void{
			value.initializationComplete();
		}
		
		
		
	}
}