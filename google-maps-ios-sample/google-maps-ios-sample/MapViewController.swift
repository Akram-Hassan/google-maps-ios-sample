import UIKit
import CoreLocation
import GoogleMaps

//High Level Functionlaity
class MapViewController: UIViewController {

    private var locationManager:CLLocationManager!
    private var userLocation:CLLocation!
    private var mapView : GMSMapView!
    
    override func loadView() {
        mapView = GMSMapView(frame: CGRect.zero)
        view = mapView
        setupSegmentedControl()
    }
    
    private func setupSegmentedControl() {
        let segmentedControl
            = UISegmentedControl(items: ["Mosques", "Banks"])
        
        segmentedControl.backgroundColor
            = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self,
                                   action: #selector(MapViewController.mapTypeChanged(_:)),
                                   for: .valueChanged)
        
        segmentedControl.backgroundColor
            = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint =
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                  constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint =
            segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint =
            segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getCurrentLocationInfo()
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            print("Mosques")
        case 1:
            print("Banks")
        default:
            break
        }
    }
}

//Map and Location Functionality
extension MapViewController: CLLocationManagerDelegate {
    func getCurrentLocationInfo() {
        locationManager = CLLocationManager()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
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

