import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WeAccept {
  static const MethodChannel _channel = const MethodChannel('flutter_accept');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<String> init({
    @required Map<String, String> billingData,
    @required String paymentKey,
    @required bool saveCardDefault,
    @required bool showSaveCard,
    @required bool showAlerts,
    @required String token,
    @required String maskedPanNumber,
    @required String buttonsColor,
  }) async {
    final String response =
        await _channel.invokeMethod('init', <String, dynamic>{
      'billingData': billingData,
      'paymentKey': paymentKey,
      'saveCardDefault': saveCardDefault,
      'showSaveCard': showSaveCard,
      'showAlerts': showAlerts,
      'token': token,
      'maskedPanNumber': maskedPanNumber,
      'buttonsColor': buttonsColor,
    });

    return response;
  }
}
