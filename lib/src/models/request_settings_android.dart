import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_bg_location/src/models/foreground_notification_config.dart';
import 'package:simple_bg_location/src/models/request_settings.dart';

import '../enums/enums.dart';

/// The RequestSetting for Android.
///
/// The Android specific request settings which you can set other then the
/// default value of [RequestSettings]
///
class AndroidRequestSettings implements RequestSettings {

  @override
  LocationAccuracy accuracy;

  @override
  int distanceFilter;
  /// Forces to use the legacy LocationManager instead of the
  /// FusedLocationProviderClient(Google Service)
  ///
  /// If this value is false. plugin will check if Google Play Services are
  /// installed on the device. If they are not installed the plugin will
  /// automatically switch to the LocationManager. However if you want to force
  /// the plugin to use the LocationManager even the Google Play Services are
  /// installed you could set this property to true
  bool forceLocationManager;

  /// Set the desired interval for active location updates, in milliseconds.
  ///
  /// This interval is `inexact`. You may not receive updates at all (if no
  /// location sources are available), or you may receive them slower than
  /// requested. You may also receive them faster than requested (if other
  /// applications are requesting location at a faster interval).
  ///
  /// If your application wants high accuracy location it should create a
  /// location request with [LocationAccuracy.best] and interval `5` seconds.
  /// more detail description check Google Play Services document. (
  /// https://developers.google.com/android/reference/com/google/android/gms/location/LocationRequest)
  int interval;

  /// Explicitly set the fastest interval for location updates, in milliseconds.
  /// this value should between `0` and `[interval]`
  ///
  /// ⚠️ Note: support by FusedLocationProviderClient. in LocationManager is only
  /// support by Android 12(Api 31) and later.
  ///
  /// if you want to receive updates at a specified interval, and can receive
  /// them faster when available, but still want a low power impact, you should
  /// consider [LocationAccuracy.medium] combined with a faster minUpdateInterval
  /// (such as 1 minute) and a slower interval(such as 60 minutes).
  int minUpdateInterval;

  /// Set the duration of this request, in milliseconds.
  ///
  /// ⚠️ Note: support by FusedLocationProviderClient. in LocationManager is only
  /// support by Android 12(Api 31) and later.
  ///
  /// The location client will automatically stop updates after the request
  /// expires.
  /// the value `1 or greater` is meaningful. 0 or negative means no duration
  /// setting. default value is `0`
  int duration;

  /// Sets the maximum wait time in milliseconds for location updates
  ///
  /// ⚠️ Note: support by FusedLocationProviderClient. in LocationManager is only
  /// support by Android 12(Api 31) and later.
  ///
  /// If you pass a value at least 2x larger than the interval, then location
  /// delivery may be delayed and multiple locations can be delivered at once.
  /// Locations are determined at the interval rate, but can be delivered in
  /// batch after the interval you set in this method. This can consume less
  /// battery and give more accurate locations, depending on the device's
  /// hardware capabilities. You should set this value to be as large as
  /// possible for your needs if you don't need immediate location delivery.
  ///
  /// ⚠️ Note: This batch mode only happened in plugin side. your application
  /// still receive location update one by one.
  ///
  /// Default is `0`, which represents no batching allowed.
  int maxUpdateDelay;

  /// Set the number of location updates.
  ///
  /// ⚠️ Note: support by FusedLocationProviderClient. in LocationManager is only
  /// support by Android 12(Api 31) and later.
  ///
  /// When using this option care must be taken to either explicitly remove the
  /// request when no longer needed or to set an expiration with duration.
  /// Otherwise in some cases if a location can't be computed, this request
  /// could stay active indefinitely consuming power.
  ///
  /// the value `1 or greater` is meaningful. 0 or negative means unlimited
  /// number of updates. default value is `0`
  int maxUpdates;

  /// The foreground service notification configure
  /// 
  /// if null will show a default notification
  ForegroundNotificationConfig? notificationConfig;

  /// create a request location update setting.
  /// 
  /// default is balance power and accuracy
  AndroidRequestSettings({
    this.accuracy = LocationAccuracy.medium,
    this.distanceFilter = 50,
    this.forceLocationManager = false,
    this.interval = 60 * 60 * 1000,
    this.minUpdateInterval = 60 * 60,
    this.duration = 0,
    this.maxUpdateDelay = 0,
    this.maxUpdates = 0,
    this.notificationConfig,
  });

  

  @override
  Map<String, dynamic> toMap() {
    return {
      'accuracy': accuracy.index,
      'distanceFilter': distanceFilter,
      'forceLocationManager': forceLocationManager,
      'interval': interval,
      'minUpdateInterval': minUpdateInterval,
      'duration': duration,
      'maxUpdateDelay': maxUpdateDelay,
      'maxUpdates': maxUpdates,
      'notificationConfig': notificationConfig?.toMap(),
    };
  }

  factory AndroidRequestSettings.fromMap(Map<String, dynamic> map) {
    return AndroidRequestSettings(
      accuracy: LocationAccuracy.values[map['accuracy']],
      distanceFilter: map['distanceFilter']?.toInt() ?? 0,
      forceLocationManager: map['forceLocationManager'] ?? false,
      interval: map['interval']?.toInt() ?? 0,
      minUpdateInterval: map['minUpdateInterval']?.toInt() ?? 0,
      duration: map['duration']?.toInt() ?? 0,
      maxUpdateDelay: map['maxUpdateDelay']?.toInt() ?? 0,
      maxUpdates: map['maxUpdates']?.toInt() ?? 0,
      notificationConfig: map['notificationConfig'] != null ? ForegroundNotificationConfig.fromMap(map['notificationConfig']) : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory AndroidRequestSettings.fromJson(String source) => AndroidRequestSettings.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AndroidRequestSettings(accuracy: $accuracy, distanceFilter: $distanceFilter, forceLocationManager: $forceLocationManager, interval: $interval, minUpdateInterval: $minUpdateInterval, duration: $duration, maxUpdateDelay: $maxUpdateDelay, maxUpdates: $maxUpdates, notificationConfig: $notificationConfig)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AndroidRequestSettings &&
      other.accuracy == accuracy &&
      other.distanceFilter == distanceFilter &&
      other.forceLocationManager == forceLocationManager &&
      other.interval == interval &&
      other.minUpdateInterval == minUpdateInterval &&
      other.duration == duration &&
      other.maxUpdateDelay == maxUpdateDelay &&
      other.maxUpdates == maxUpdates &&
      other.notificationConfig == notificationConfig;
  }

  @override
  int get hashCode {
    return accuracy.hashCode ^
      distanceFilter.hashCode ^
      forceLocationManager.hashCode ^
      interval.hashCode ^
      minUpdateInterval.hashCode ^
      duration.hashCode ^
      maxUpdateDelay.hashCode ^
      maxUpdates.hashCode ^
      notificationConfig.hashCode;
  }
}
