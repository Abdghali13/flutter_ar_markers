import 'package:flutter/material.dart';
import 'package:flutter_ar_markers/flutter_ar_markers.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Markers Example',
      home: ARMarkersScreen(),
    );
  }
}

class ARMarkersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AR Markers Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: _startAR,
          child: Text('Start AR'),
        ),
      ),
    );
  }

  void _startAR() async {
    List<Map<String, dynamic>> markers = [
      {
        'id': 1,
        'latitude': 46.94809,
        'longitude': 7.44744,
        'name': 'Shop A',
      },
      {
        'id': 2,
        'latitude': 46.94809,
        'longitude': 7.44744,
        'name': 'Shop B',
      },
    ];

    try {
      // Send markers to native platform
      await FlutterARMarkers.sendMarkers(markers);

      // Listen for marker clicks
      int? clickedId = await FlutterARMarkers.onMarkerClick();
      print("Marker clicked with ID: $clickedId");
    } catch (e) {
      print("Error: $e");
    }
  }
}
