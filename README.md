# GPS ANE V2.0 for Android+iOS
Although there is a GPS API coming with Air SDK, in a real app development scenario, you need a better GPS solution. You need an exact and faster Gps solution which you can really trust. That’s why we decided to build this cool GPS extension. it’s highly optimized for automatic provider picker to ensure your app will get user location as fast as possible even if indoor. it’s also optimized for battery usage so you don’t have to worry about your app’s battery usage at all. try the extension right now for free and see how fast it is. 

**Main Features:**
* start/stop GPS service periodically
* get one time location finder for better battery usage
* geocoding reverse to convert gps coordinates to real addresses
* geocoding reverse to convert gps coordinates to real addresses

checkout here for the commercial version: http://myappsnippet.com/gps-air-extension/

![GPS ANE](http://myappsnippet.com/wp-content/uploads/2015/09/gps-air-extension_preview.jpg)

**NOTICE: the demo ANE works only after you hit the "OK" button in the dialog which opens. in your tests make sure that you are NOT calling other ANE methods prior to hitting the "OK" button.**

# USAGE - Location:
```actionscript
     import com.doitflash.air.extensions.gps.Gps;
     import com.doitflash.air.extensions.gps.LocationAccuracy;
     import com.doitflash.air.extensions.gps.Location;
     import com.doitflash.air.extensions.gps.GpsEvent;
     
     Gps.init(); // call init only once in your project
     
     // will return null if no known last location has been found
     Gps.location.getLastLocation(onLocationResult);
     
     // may take a while depending on when gps info is found
     Gps.location.getCurrentLocation(onLocationResult); 
     
     function onLocationResult($result:Location):void
     {
         if (!$result)
         {
             trace("location is null");
             return;
         }
         
         trace("accuracy = " + $result.accuracy);
         trace("altitude = " + $result.altitude);
         trace("bearing = " + $result.bearing);
         trace("latitude = " + $result.latitude);
         trace("longitude = " + $result.longitude);
         trace("provider = " + $result.provider);
         trace("speed = " + $result.speed);
         trace("time = " + $result.time);
         trace("---------------------------------");
     }
     
     // use the start method to get gps information periodically (the gps icon will be shown at your device status bar)
     Gps.location.addEventListener(GpsEvent.LOCATION_UPDATE, onLocationUpdate);
     Gps.location.start(LocationAccuracy.HIGH, 0, 5000);
     
     // simply stop the gps service when you don't need to get location information periodically anymore.
     Gps.location.removeEventListener(GpsEvent.LOCATION_UPDATE, onLocationUpdate);
     Gps.location.stop();
     
     function onLocationUpdate(e:GpsEvent):void
     {
         trace(" ------------------------------- onLocationUpdate");
         var loc:Location = e.param;
         trace("accuracy = " + loc.accuracy);
         trace("altitude = " + loc.altitude);
         trace("bearing = " + loc.bearing);
         trace("latitude = " + loc.latitude);
         trace("longitude = " + loc.longitude);
         trace("provider = " + loc.provider);
         trace("speed = " + loc.speed);
         trace("time = " + loc.time);
         trace("---------------------------------");
     }
```

# USAGE - Geocoding
```actionscript
     Gps.geocoding.reverse(-33.7969235, 150.9224326, onResultGeocodingReverse);
     
     function onResultGeocodingReverse($address:Array):void
     {
         // there might be more than one address found for this location
         trace("$address.length = " + $address.length);
         trace("$address = " + JSON.stringify($address));
         trace("-----------------------------");
     }
     
     Gps.geocoding.direct("Sydney", onResultGeocodingDirect);
     
     function onResultGeocodingDirect($location:Array):void
     {
         // there might be more than one location found for this address
         trace("$location.length = " + $location.length);
         trace("$location = " + JSON.stringify($location));
         trace("-----------------------------");
     }
```

# Air .xml manifest
```xml
<!--
FOR ANDROID:
-->
<manifest android:installLocation="auto">
		<uses-sdk android:minSdkVersion="10" android:targetSdkVersion="22" />
		<uses-permission android:name="android.permission.WAKE_LOCK" />
		<uses-permission android:name="android.permission.INTERNET" />
		
		<!-- required for GPS -->
		<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
		<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
		<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
		<uses-permission android:name="com.google.android.providers.gsf.permission.READ_GSERVICES" />
		<uses-permission android:name="com.google.android.gms.permission.ACTIVITY_RECOGNITION" />
		
		<application android:hardwareAccelerated="true" android:allowBackup="true">
			
			<activity android:hardwareAccelerated="true">
				<intent-filter>
					<action android:name="android.intent.action.MAIN" />
					<category android:name="android.intent.category.LAUNCHER" />
				</intent-filter>
				<intent-filter>
					<action android:name="android.intent.action.VIEW" />
					<category android:name="android.intent.category.BROWSABLE" />
					<category android:name="android.intent.category.DEFAULT" />
				</intent-filter>
			</activity>
			
			<!-- required for GPS -->
			<service android:name="com.doitflash.gps.services.AndroidGeocodingProvider$AndroidGeocodingService" android:exported="false" />
			<service android:name="com.doitflash.gps.services.ActivityGooglePlayServicesProvider$ActivityRecognitionService" android:exported="false" />
			<service android:name="com.doitflash.gps.services.GeofencingGooglePlayServicesProvider$GeofencingService" android:exported="false" />
			<meta-data android:name="com.google.android.gms.version" android:value="@integer/google_play_services_version" />
			
		</application>
		
</manifest>




<!--
FOR iOS:
-->
<InfoAdditions>
		<key>MinimumOSVersion</key>
		<string>6.1</string>
		
		<key>UIStatusBarStyle</key>
		<string>UIStatusBarStyleBlackOpaque</string>
		
		<key>UIRequiresPersistentWiFi</key>
		<string>NO</string>
		
		<key>UIPrerenderedIcon</key>
		<true />
		
		<!--required for GPS-->
		<key>NSLocationUsageDescription</key>
		<string>I need location 1</string>
		
		<key>NSLocationWhenInUseUsageDescription</key>
		<string>I need location 2</string>
		
		<key>NSLocationAlwaysUsageDescription</key>
		<string>I need location 3</string>
		
		<key>UIDeviceFamily</key>
		<array>
			<!-- iPhone support -->
			<string>1</string>
			<!-- iPad support -->
			<string>2</string>
		</array>
</InfoAdditions>
	
	
	
	
<!--
Embedding the ANE:
-->
  <extensions>
	<!-- And finally, you need to introduce the extensions here. you will need commonDependenciesV4.0.ane or higher -->
    <extensionID>com.doitflash.air.extensions.dependency</extensionID>
    <extensionID>com.doitflash.air.extensions.gps</extensionID>
  </extensions>
-->
```

# Requirements 
1. Android API 10 or higher
2. iOS SDK 6.1 or higher
3. [commonDependenciesV4.0.ane](https://github.com/myflashlab/common-dependencies-ANE) or higher
5. on Android you have to compile on debug or captive (shared compilation will fail)