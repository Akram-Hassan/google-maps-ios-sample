import UIKit
import CoreLocation
import GoogleMaps

class MapViewController: UIViewController {

    private var locationManager:CLLocationManager!
    private var userLocation:CLLocation!
    private var mapView : GMSMapView!
    
    override func loadView() {
        mapView = GMSMapView(frame: CGRect.zero)
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getCurrentLocationInfo()
    }
    
    
    func getCurrentLocationInfo() {
        locationManager = CLLocationManager()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    

}

extension MapViewController: CLLocationManagerDelegate {
    
    func animateMapToLocation(location: CLLocation) {
        mapView.animate(toLocation: location.coordinate)

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

        marker.map = mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0] as CLLocation
        
        manager.stopUpdatingLocation()
        
        animateMapToLocation(location: userLocation)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("\(error)")
    }
}

