import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WeAccept {
  static const MethodChannel _channel = const MethodChannel('flutter_accept');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<Map<dynamic, dynamic>> pay({
    @required amount,
  }) async {
    final Map<dynamic, dynamic> response =
        await _channel.invokeMethod('pay', <String, String>{
      'amount': amount,
    });

    return response;
  }
}
