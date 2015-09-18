package 
{
	import com.doitflash.air.extensions.gps.Gps;
	import com.doitflash.air.extensions.gps.LocationAccuracy;
	import com.doitflash.air.extensions.gps.Location;
	import com.doitflash.air.extensions.gps.GpsEvent;
	import flash.utils.setTimeout;
	
	import com.doitflash.consts.Direction;
	import com.doitflash.consts.Orientation;
	
	import com.doitflash.mobileProject.commonCpuSrc.DeviceInfo;
	
	import com.doitflash.starling.utils.list.List;
	
	import com.doitflash.text.modules.MySprite;
	
	import com.doitflash.tools.sizeControl.FileSizeConvertor;
	
	import com.luaye.console.C;
	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import flash.events.Event;
	import flash.events.StatusEvent;
	import flash.events.InvokeEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import flash.filesystem.File;
	
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * 
	 * @author Hadi Tavakoli - 4/27/2015 2:43 PM
	 */
	public class MainFinal extends Sprite 
	{		
		private const BTN_WIDTH:Number = 150;
		private const BTN_HEIGHT:Number = 60;
		private const BTN_SPACE:Number = 2;
		private var _txt:TextField;
		private var _body:Sprite;
		private var _list:List;
		private var _numRows:int = 1;
		
		public function MainFinal():void 
		{
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, handleActivate);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate);
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke);
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handleKeys);
			
			stage.addEventListener(Event.RESIZE, onResize);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			C.startOnStage(this, "`");
			C.commandLine = false;
			C.commandLineAllowed = false;
			C.x = 100;
			C.width = 500;
			C.height = 250;
			C.strongRef = true;
			C.visible = true;
			C.scaleX = C.scaleY = DeviceInfo.dpiScaleMultiplier;
			
			_txt = new TextField();
			_txt.autoSize = TextFieldAutoSize.LEFT;
			_txt.antiAliasType = AntiAliasType.ADVANCED;
			_txt.multiline = true;
			_txt.wordWrap = true;
			_txt.embedFonts = false;
			_txt.htmlText = "<font face='Arimo' color='#333333' size='20'><b>GPS ANE V" + Gps.VERSION + " for adobe air</b></font>";
			_txt.scaleX = _txt.scaleY = DeviceInfo.dpiScaleMultiplier;
			this.addChild(_txt);
			
			_body = new Sprite();
			this.addChild(_body);
			
			_list = new List();
			_list.holder = _body;
			_list.itemsHolder = new Sprite();
			_list.orientation = Orientation.VERTICAL;
			_list.hDirection = Direction.LEFT_TO_RIGHT;
			_list.vDirection = Direction.TOP_TO_BOTTOM;
			_list.space = BTN_SPACE;
			
			init();
			onResize();
		}
		
		private function onInvoke(e:InvokeEvent):void
		{
			NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE, onInvoke);
		}
		
		private function handleActivate(e:Event):void 
		{
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
		}
		
		private function handleDeactivate(e:Event):void 
		{
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
		}
		
		private function handleKeys(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.BACK)
            {
				e.preventDefault();
				
				NativeApplication.nativeApplication.exit();
            }
		}
		
		private function onResize(e:*=null):void
		{
			if (_txt)
			{
				_txt.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);
				
				C.x = 0;
				C.y = _txt.y + _txt.height + 0;
				C.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);
				C.height = 300 * (1 / DeviceInfo.dpiScaleMultiplier);
			}
			
			if (_list)
			{
				_numRows = Math.floor(stage.stageWidth / (BTN_WIDTH * DeviceInfo.dpiScaleMultiplier + BTN_SPACE));
				_list.row = _numRows;
				_list.itemArrange();
			}
			
			if (_body)
			{
				_body.y = stage.stageHeight - _body.height;
			}
		}
		
		private function init():void
		{
			Gps.init(); // call init only once in your project
			// Gps.dispose();
			
			var btn1:MySprite = createBtn("getLastLocation");
			btn1.addEventListener(MouseEvent.CLICK, getLastLocation);
			_list.add(btn1);
			
			function getLastLocation(e:MouseEvent):void
			{
				Gps.location.getLastLocation(onLocationResult); // will return null if no known last location has been found
			}
			
			// -------------------------
			
			var btn2:MySprite = createBtn("getCurrentLocation");
			btn2.addEventListener(MouseEvent.CLICK, getCurrentLocation);
			_list.add(btn2);
			
			function getCurrentLocation(e:MouseEvent):void
			{
				Gps.location.getCurrentLocation(onLocationResult); // may take a while depending on when gps info is found
			}
			
			function onLocationResult($result:Location):void
			{
				if (!$result)
				{
					C.log("location is null");
					return;
				}
				
				C.log("accuracy = " + $result.accuracy);
				C.log("altitude = " + $result.altitude);
				C.log("bearing = " + $result.bearing);
				C.log("latitude = " + $result.latitude);
				C.log("longitude = " + $result.longitude);
				C.log("provider = " + $result.provider);
				C.log("speed = " + $result.speed);
				C.log("time = " + $result.time);
				C.log("---------------------------------");
			}
			
			// -------------------------
			
			var btn3:MySprite = createBtn("start location");
			btn3.addEventListener(MouseEvent.CLICK, start);
			_list.add(btn3);
			
			function start(e:MouseEvent):void
			{
				Gps.location.addEventListener(GpsEvent.LOCATION_UPDATE, onLocationUpdate);
				Gps.location.start(LocationAccuracy.HIGH, 0, 5000);
			}
			
			// -------------------------
			
			var btn4:MySprite = createBtn("stop location");
			btn4.addEventListener(MouseEvent.CLICK, stop);
			_list.add(btn4);
			
			function stop(e:MouseEvent):void
			{
				Gps.location.removeEventListener(GpsEvent.LOCATION_UPDATE, onLocationUpdate);
				Gps.location.stop();
			}
			
			function onLocationUpdate(e:GpsEvent):void
			{
				C.log(" ------------------------------- onLocationUpdate");
				var loc:Location = e.param;
				C.log("accuracy = " + loc.accuracy);
				C.log("altitude = " + loc.altitude);
				C.log("bearing = " + loc.bearing);
				C.log("latitude = " + loc.latitude);
				C.log("longitude = " + loc.longitude);
				C.log("provider = " + loc.provider);
				C.log("speed = " + loc.speed);
				C.log("time = " + loc.time);
				C.log("---------------------------------");
			}
			
			// -------------------------
			
			var btn5:MySprite = createBtn("geocoding.reverse");
			btn5.addEventListener(MouseEvent.CLICK, reverse);
			_list.add(btn5);
			
			function reverse(e:MouseEvent):void
			{
				Gps.geocoding.reverse(-33.7969235, 150.9224326, onResultGeocodingReverse);
			}
			
			function onResultGeocodingReverse($address:Array):void
			{
				// there might be more than one address found for this location
				C.log("$address.length = " + $address.length);
				C.log("$address = " + JSON.stringify($address));
				C.log("-----------------------------");
			}
			
			// -------------------------
			
			var btn6:MySprite = createBtn("geocoding.direct");
			btn6.addEventListener(MouseEvent.CLICK, direct);
			_list.add(btn6);
			
			function direct(e:MouseEvent):void
			{
				Gps.geocoding.direct("Sydney", onResultGeocodingDirect);
			}
			
			function onResultGeocodingDirect($location:Array):void
			{
				// there might be more than one location found for this address
				C.log("$location.length = " + $location.length);
				C.log("$location = " + JSON.stringify($location));
				C.log("-----------------------------");
			}
			
			// -------------------------
			
			var btn7:MySprite = createBtn("check state");
			btn7.addEventListener(MouseEvent.CLICK, state);
			_list.add(btn7);
			
			function state(e:MouseEvent):void
			{
				C.log("locationServicesEnabled = " + Gps.state.locationServicesEnabled);
			}
			
			// -------------------------
			// -------------------------
			// -------------------------
			// -------------------------
			
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		private function createBtn($str:String):MySprite
		{
			var sp:MySprite = new MySprite();
			sp.addEventListener(MouseEvent.MOUSE_OVER,  onOver);
			sp.addEventListener(MouseEvent.MOUSE_OUT,  onOut);
			sp.addEventListener(MouseEvent.CLICK,  onOut);
			sp.bgAlpha = 1;
			sp.bgColor = 0xDFE4FF;
			sp.drawBg();
			sp.width = BTN_WIDTH * DeviceInfo.dpiScaleMultiplier;
			sp.height = BTN_HEIGHT * DeviceInfo.dpiScaleMultiplier;
			
			function onOver(e:MouseEvent):void
			{
				sp.bgAlpha = 1;
				sp.bgColor = 0xFFDB48;
				sp.drawBg();
			}
			
			function onOut(e:MouseEvent):void
			{
				sp.bgAlpha = 1;
				sp.bgColor = 0xDFE4FF;
				sp.drawBg();
			}
			
			var format:TextFormat = new TextFormat("Arimo", 16, 0x666666, null, null, null, null, null, TextFormatAlign.CENTER);
			
			var txt:TextField = new TextField();
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.mouseEnabled = false;
			txt.multiline = true;
			txt.wordWrap = true;
			txt.scaleX = txt.scaleY = DeviceInfo.dpiScaleMultiplier;
			txt.width = sp.width * (1 / DeviceInfo.dpiScaleMultiplier);
			txt.defaultTextFormat = format;
			txt.text = $str;
			
			txt.y = sp.height - txt.height >> 1;
			sp.addChild(txt);
			
			return sp;
		}
	}
	
}