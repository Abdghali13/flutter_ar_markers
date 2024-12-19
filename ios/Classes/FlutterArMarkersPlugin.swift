import Flutter
import UIKit
import HDAugmentedReality
import CoreLocation

public class FlutterArMarkersPlugin: NSObject, FlutterPlugin, ARDataSource {
    private var arViewController: ARViewController?
    private var resultCallback: FlutterResult?
    private var annotations: [ARAnnotation] = []

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_ar_markers", binaryMessenger: registrar.messenger())
        let instance = FlutterArMarkersPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "sendMarkers":
            guard let args = call.arguments as? [[String: Any]] else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Markers must be a list", details: nil))
                return
            }
            setupMarkers(args)
            result(nil)
        case "onMarkerClick":
            self.resultCallback = result
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func setupMarkers(_ markers: [[String: Any]]) {
        annotations.removeAll()

        for marker in markers {
            guard let id = marker["id"] as? Int,
                  let latitude = marker["latitude"] as? Double,
                  let longitude = marker["longitude"] as? Double,
                  let name = marker["name"] as? String else { continue }

            let location = CLLocation(latitude: latitude, longitude: longitude)
            if let annotation = ARAnnotation(identifier: "\(id)", title: name, location: location) {
                annotations.append(annotation)
            }
        }

        DispatchQueue.main.async {
            self.showARView()
        }
    }

    private func showARView() {
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else { return }

        // Check if another ARViewController is already being presented
        if rootVC.presentedViewController is ARViewController {
            print("ARViewController is already being presented.")
            return
        }

        // Ensure location permissions
        let locationHandler = LocationPermissionHandler()
        locationHandler.requestLocationPermission()

        let arVC = ARViewController()
        arVC.dataSource = self
        self.arViewController = arVC
        rootVC.present(arVC, animated: true, completion: nil)
    }

    public func ar(_ arViewController: ARViewController, viewForAnnotation annotation: ARAnnotation) -> ARAnnotationView {
        let annotationView = ARAnnotationView()
        annotationView.annotation = annotation
        annotationView.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        return annotationView
    }
}
