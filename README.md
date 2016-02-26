# GPS ANE V3.0.0 for Android+iOS
Although there is a GPS API coming with Air SDK, in a real app development scenario, you need a better GPS solution. You need an exact and faster Gps solution which you can really trust. That's why we decided to build this cool GPS extension. it's highly optimized for automatic provider picker to ensure your app will get user location as fast as possible even if indoor. it's also optimized for battery usage so you don't have to worry about your app's battery usage at all. try the extension right now for free and see how fast it is. 

**Main Features:**
* start/stop GPS service periodically
* get one time location finder for better battery usage
* geocoding reverse to convert gps coordinates to real addresses
* geocoding reverse to convert gps coordinates to real addresses

# Demo .apk
you may like to see the ANE in action? [Download demo .apk](https://github.com/myflashlab/GPS-ANE/tree/master/FD/dist)

**NOTICE**: the demo ANE works only after you hit the "OK" button in the dialog which opens. in your tests make sure that you are NOT calling other ANE methods prior to hitting the "OK" button.
[Download the ANE](https://github.com/myflashlab/GPS-ANE/tree/master/FD/lib)

# Air Usage - location
```actionscript
     import com.myflashlab.air.extensions.gps.Gps;
     import com.myflashlab.air.extensions.gps.LocationAccuracy;
     import com.myflashlab.air.extensions.gps.Location;
     import com.myflashlab.air.extensions.gps.GpsEvent;
     
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

# Air Usage - Geocoding
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
			<service android:name="io.nlopez.smartlocation.geocoding.providers.AndroidGeocodingProvider$AndroidGeocodingService" android:exported="false" />
			<service android:name="io.nlopez.smartlocation.activity.providers.ActivityGooglePlayServicesProvider$ActivityRecognitionService" android:exported="false" />
			<service android:name="io.nlopez.smartlocation.geofencing.providers.GeofencingGooglePlayServicesProvider$GeofencingService" android:exported="false" />
			<meta-data android:name="com.google.android.gms.version" android:value="@integer/google_play_services_version" />
			
		</application>
		
</manifest>




<!--
FOR iOS:
-->
<InfoAdditions>
		<key>MinimumOSVersion</key>
		<string>7.1</string>
		
		<key>UIStatusBarStyle</key>
		<string>UIStatusBarStyleBlackOpaque</string>
		
		<key>UIRequiresPersistentWiFi</key>
		<string>NO</string>
		
		<key>UIPrerenderedIcon</key>
		<true />
		
		<!--required for GPS-->
		<key>NSLocationUsageDescription</key>
		<string>I need location UsageDescription</string>
		
		<key>NSLocationWhenInUseUsageDescription</key>
		<string>I need location WhenInUseUsageDescription</string>
		
		<key>NSLocationAlwaysUsageDescription</key>
		<string>I need location AlwaysUsageDescription</string>
		
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
    <extensionID>com.myflashlab.air.extensions.dependency.androidSupport</extensionID>
    <extensionID>com.myflashlab.air.extensions.dependency.overrideAir</extensionID>
    <extensionID>com.myflashlab.air.extensions.dependency.googlePlayServices.base</extensionID>
    <extensionID>com.myflashlab.air.extensions.dependency.googlePlayServices.basement</extensionID>
    <extensionID>com.myflashlab.air.extensions.dependency.googlePlayServices.location</extensionID>
    <extensionID>com.myflashlab.air.extensions.gps</extensionID>
  </extensions>
-->
```

# Requirements
1. Android API 15 or higher
2. iOS SDK 7.1 or higher
3. This ANE is dependent on **androidSupport.ane**, **googlePlayServices_base.ane**, **googlePlayServices_basement.ane**, **googlePlayServices_location.ane** and **overrideAir.ane** You need to add these ANEs to your project too. [Download them from here:](https://github.com/myflashlab/common-dependencies-ANE)
5. on Android you have to compile on debug or captive (shared compilation will fail)

# Commercial Version
http://www.myflashlabs.com/product/gps-ane-adobe-air-native-extension/

![GPS ANE](http://www.myflashlabs.com/wp-content/uploads/2015/11/product_adobe-air-ane-extension-gps-595x738.jpg)

# Tutorials
[How to embed ANEs into **FlashBuilder**, **FlashCC** and **FlashDevelop**](https://www.youtube.com/watch?v=Oubsb_3F3ec&list=PL_mmSjScdnxnSDTMYb1iDX4LemhIJrt1O)  

# Tutorials
[How to embed ANEs into **FlashBuilder**, **FlashCC** and **FlashDevelop**](https://www.youtube.com/watch?v=Oubsb_3F3ec&list=PL_mmSjScdnxnSDTMYb1iDX4LemhIJrt1O)  

# Changelog
*Feb 26, 2016 - V3.0.0*
* Updated GooglePlayServices to V8.4.0
* manifest services now changed to 
			```
			<service android:name="io.nlopez.smartlocation.geocoding.providers.AndroidGeocodingProvider$AndroidGeocodingService" android:exported="false" />
			<service android:name="io.nlopez.smartlocation.activity.providers.ActivityGooglePlayServicesProvider$ActivityRecognitionService" android:exported="false" />
			<service android:name="io.nlopez.smartlocation.geofencing.providers.GeofencingGooglePlayServicesProvider$GeofencingService" android:exported="false" />
			```
* Removed the global dependency to GooglePlayServices and instead, the following ANEs must be added: [**androidSupport.ane**, **googlePlayServices_base.ane**, **googlePlayServices_basement.ane**, **googlePlayServices_location.ane** and **overrideAir.ane**](https://github.com/myflashlab/common-dependencies-ANE)


*Jan 20, 2016 - V2.9.2*
* bypassing xCode 7.2 bug causing iOS conflict when compiling with AirSDK 20 without waiting on Adobe or Apple to fix the problem. This is a must have upgrade for your app to make sure you can compile multiple ANEs in your project with AirSDK 20 or greater. https://forums.adobe.com/thread/2055508 https://forums.adobe.com/message/8294948


*Dec 20, 2015 - V2.9.1*
* minor bug fixes


*Nov 03, 2015 - V2.9*
* doitflash devs merged into MyFLashLab Team


*Sep 18, 2015 - V2.0*
* automatic Gps provider picker
* optimized for indoor location finder
* supporting iOS + Android
* supporting geocoding direct and reverse


*Nov 10, 2013 - V1.0*
* beginning of the journey!