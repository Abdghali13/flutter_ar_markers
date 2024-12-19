
# flutter_ar_markers

A Flutter plugin to integrate augmented reality (AR) markers into your iOS applications using the [HDAugmentedReality](https://github.com/DanijelHuis/HDAugmentedReality) framework. This plugin allows you to display AR markers based on geographical coordinates and interact with them in real-time.

## Features

- Display custom AR markers based on latitude, longitude, and name.
- Interactive marker support: handle marker tap events and retrieve marker IDs.
- Uses the [HDAugmentedReality](https://github.com/DanijelHuis/HDAugmentedReality) library for iOS.

---

## Installation

### Using GitHub
To use this plugin in your project, add the following to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_ar_markers:
    git:
      url: https://github.com/Abdghali13/flutter_ar_markers
```

### iOS Configuration

#### Permissions
Update your iOS app's `Info.plist` file to include the required permissions for location and camera usage:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to your location to display AR markers.</string>
<key>NSCameraUsageDescription</key>
<string>This app needs access to your camera to display AR features.</string>
```

#### CocoaPods
Ensure your iOS project uses `CocoaPods` by installing dependencies in the example app:

```bash
cd example/ios
pod install
```

---

## Usage

Here's a basic example of how to use the `flutter_ar_markers` plugin:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_ar_markers/flutter_ar_markers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ARMarkersExample(),
    );
  }
}

class ARMarkersExample extends StatelessWidget {
  void _sendMarkers() async {
    await FlutterARMarkers.sendMarkers([
      {'id': 1, 'latitude': 37.7749, 'longitude': -122.4194, 'name': 'Golden Gate Bridge'},
      {'id': 2, 'latitude': 34.0522, 'longitude': -118.2437, 'name': 'Los Angeles'},
    ]);

    final clickedId = await FlutterARMarkers.onMarkerClick();
    print('Marker with ID $clickedId clicked');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AR Markers Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: _sendMarkers,
          child: Text('Show AR Markers'),
        ),
      ),
    );
  }
}
```

---

## Development

### Folder Structure
The plugin follows this structure:

```
flutter_ar_markers/
├── lib/
│   ├── flutter_ar_markers.dart  # Dart interface
├── ios/
│   ├── Classes/
│   │   ├── FlutterArMarkersPlugin.swift  # Main iOS implementation
│   │   ├── LocationPermissionHandler.swift  # Handles iOS location permissions
│   ├── FlutterArMarkers.podspec  # CocoaPods specification
├── example/
│   ├── ios/
│   │   ├── Podfile  # CocoaPods configuration
│   │   ├── Info.plist  # Example app permissions
│   ├── lib/
│   │   ├── main.dart  # Example app entry point
├── README.md  # Documentation
```

---

## Troubleshooting

1. **Error: No such module 'HDAugmentedReality'**
   - Ensure `pod install` has been run in the `example/ios` directory.
   - Verify that `HDAugmentedReality` is included in the `Podfile` and installed.

2. **Error: Location permission denied**
   - Ensure you’ve added the necessary permissions (`NSLocationWhenInUseUsageDescription`) in your `Info.plist`.

3. **Build Issues**
   - Clean the project and rebuild:
     ```bash
     flutter clean
     flutter pub get
     cd ios
     pod install
     cd ..
     flutter run
     ```

---

## Contributions

Contributions are welcome! Feel free to open issues or submit pull requests to improve this plugin.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

