GPS Adobe Air Native Extension

*Sep 19, 2018 - V3.3.3*
* Removed androidSupport dependency ANE.
* This ANE depends on the following ANEs now.
	* [permissionCheck.ane](https://github.com/myflashlab/PermissionCheck-ANE/) *required on iOS/Android*
	* overrideAir.ane *required on iOS/Android*
	* androidSupport-core.ane *required on Android*
	* androidSupport-v4.ane *required on Android*
	* googlePlayServices_base.ane *required on Android*
	* googlePlayServices_basement.ane *required on Android*
	* googlePlayServices_location.ane *required on Android*
* iOS 11+ requires a new key in the plist manifest: ```<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>```

*Dec 15, 2017 - V3.3.2*
* Optimized for [ANE-LAB software](https://github.com/myflashlab/ANE-LAB).

*May 19, 2017 - V3.3.0*
* Added the following command: ```Gps.requestAlwaysAuthorization();```. Fix for [this issue](https://github.com/myflashlab/GPS-ANE/issues/23)
* Updated the Android libraries which resulted in huge decrease in the ANE file size.
* You will need AIR SDK 25 or higher to compile the ANE.

*Mar 20, 2017 - V3.2.1*
* Even if you are building for iOS only, you still need to include the following ANE as the dependency overrideAir.ane V4.0.0
* Updated Android SDK to V10.2.0 and you need to make sure you are using the [latest version of the dependency files](https://github.com/myflashlab/common-dependencies-ANE).
* MinimumOSVersion to support the ANE is iOS 8.0

*Nov 09, 2016 - V3.2.0*
* Optimized for Android manual permissions if you are targeting AIR SDK 24+

*Jun 05, 2016 - V3.1.0*
* Updated GooglePlayServices to V9.0.1. you need to update ```googlePlayServices_base.ane```, ```googlePlayServices_basement.ane``` and ```googlePlayServices_location.ane``` to V9.0.1


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