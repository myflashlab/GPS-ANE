# GPS ANE for Android+iOS
Although there is a GPS API coming with AIR SDK, in a real app development scenario, you need a better GPS solution. You need an exact and faster Gps solution which you can really trust. That's why we decided to build this cool GPS extension. it's highly optimized for automatic provider picker to ensure your app will get user location as fast as possible even if indoor. it's also optimized for battery usage so you don't have to worry about your app's battery usage at all. try the extension right now for free and see how fast it is. 

**Main Features:**
* start/stop GPS service periodically
* get one time location finder for better battery usage
* geocoding reverse to convert gps coordinates to real addresses
* geocoding reverse to convert gps coordinates to real addresses

[find the latest **asdoc** for this ANE here.](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/gps/package-detail.html)

# AIR Usage - location
For the complete AS3 code usage, see the [demo project here](https://github.com/myflashlab/GPS-ANE/blob/master/AIR/src/MainFinal.as).

```actionscript
     import com.myflashlab.air.extensions.gps.*;

     /*
        Make sure you have asked for location permission using the
        permissionCheck ANE.
     */
     
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

# AIR Usage - Geocoding
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

# AIR .xml manifest
```xml
<!--
FOR ANDROID:
-->
<manifest android:installLocation="auto">
		
		<uses-permission android:name="android.permission.WAKE_LOCK" />
		<uses-permission android:name="android.permission.INTERNET" />
		<uses-sdk android:targetSdkVersion="26"/>
		
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
		<string>8.0</string>
		
		<key>UIStatusBarStyle</key>
		<string>UIStatusBarStyleBlackOpaque</string>
		
		<key>UIRequiresPersistentWiFi</key>
		<string>NO</string>
		
		<key>UIPrerenderedIcon</key>
		<true />
		
		<!--required for GPS-->
		<key>NSLocationWhenInUseUsageDescription</key>
		<string>I need location reason</string>
		
		<key>NSLocationAlwaysUsageDescription</key>
		<string>I need location reason</string>
		
		<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
		<string>I need location reason</string>
		
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

        <extensionID>com.myflashlab.air.extensions.gps</extensionID>

        <!-- Required for gps ANE to work -->
        <extensionID>com.myflashlab.air.extensions.permissionCheck</extensionID>
	
	    <!-- Dependency ANEs https://github.com/myflashlab/common-dependencies-ANE -->
        <extensionID>com.myflashlab.air.extensions.dependency.androidSupport.core</extensionID>
        <extensionID>com.myflashlab.air.extensions.dependency.androidSupport.v4</extensionID>
        <extensionID>com.myflashlab.air.extensions.dependency.overrideAir</extensionID>
        <extensionID>com.myflashlab.air.extensions.dependency.googlePlayServices.base</extensionID>
        <extensionID>com.myflashlab.air.extensions.dependency.googlePlayServices.basement</extensionID>
        <extensionID>com.myflashlab.air.extensions.dependency.googlePlayServices.location</extensionID>

    </extensions>
-->
```

# Requirements
* Android API 15+
* iOS SDK 8.0+
* AIR SDK 30+

# Permissions
Below are the list of Permissions this ANE might require. Check out the demo project available at this repository to see how we have used the [PermissionCheck ANE](http://www.myflashlabs.com/product/native-access-permission-check-settings-menu-air-native-extension/) to ask for the permissions.

Necessary | Optional
--------------------------- | ---------------------------
[SOURCE_LOCATION](https://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/nativePermissions/PermissionCheck.html#SOURCE_LOCATION) for Android | [SOURCE_LOCATION_ALWAYS](https://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/nativePermissions/PermissionCheck.html#SOURCE_LOCATION_ALWAYS) for iOS  
[SOURCE_LOCATION_WHEN_IN_USE](https://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/nativePermissions/PermissionCheck.html#SOURCE_LOCATION_WHEN_IN_USE) for iOS | -

# Commercial Version
https://www.myflashlabs.com/product/gps-ane-adobe-air-native-extension/

[![GPS ANE](https://www.myflashlabs.com/wp-content/uploads/2015/11/product_adobe-air-ane-extension-gps-2018-595x738.jpg)](https://www.myflashlabs.com/product/gps-ane-adobe-air-native-extension/)

# Tutorials
[How to embed ANEs into **FlashBuilder**, **FlashCC** and **FlashDevelop**](https://www.youtube.com/watch?v=Oubsb_3F3ec&list=PL_mmSjScdnxnSDTMYb1iDX4LemhIJrt1O)  

# Premium Support #
[![Premium Support package](https://www.myflashlabs.com/wp-content/uploads/2016/06/professional-support.jpg)](https://www.myflashlabs.com/product/myflashlabs-support/)
If you are an active MyFlashLabs club member, you will have access to our private and secure support ticket system for all our ANEs. Even if you are not a member, you can still receive premium help if you purchase the [premium support package](https://www.myflashlabs.com/product/myflashlabs-support/).