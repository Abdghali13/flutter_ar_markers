
public class LocationPermissionHandler: NSObject, CLLocationManagerDelegate {
    public let locationManager = CLLocationManager()

    public func requestLocationPermission() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.global().async {
            switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                print("Location permission granted.")
            case .denied, .restricted:
                print("Location permission denied.")
            case .notDetermined:
                print("Location permission not determined.")
            @unknown default:
                print("Unknown location authorization status.")
            }
        }
    }
}
