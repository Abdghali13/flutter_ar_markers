import 'package:flutter/services.dart';

class FlutterARMarkers {
  static const MethodChannel _channel = MethodChannel('flutter_ar_markers');

  /// Send markers to the native platform
  static Future<void> sendMarkers(List<Map<String, dynamic>> markers) async {
    await _channel.invokeMethod('sendMarkers', markers);
  }

  /// Listen for marker click events
  static Future<int?> onMarkerClick() async {
    final id = await _channel.invokeMethod('onMarkerClick');
    return id;
  }
}
