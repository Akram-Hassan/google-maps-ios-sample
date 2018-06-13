import UIKit
import CoreLocation
import GoogleMaps

//High Level Functionlaity
class MapViewController: UIViewController {

    private var locationManager:CLLocationManager!
    private var userLocation:CLLocation!
    private var mapView : GMSMapView!
    private let zoomLevel: Float = 15
    
    override func loadView() {
        setupMap()
        setupSegmentedControl()
    }
    
    private func setupMap() {
        mapView = GMSMapView(frame: CGRect.zero)
        view = mapView
        mapView.isHidden = true
    }
    
    private func setupSegmentedControl() {
        let segmentedControl
            = UISegmentedControl(items: ["Mosques", "Banks"])
        segmentedControl.backgroundColor = UIColor.white
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self,
                                   action: #selector(MapViewController.mapTypeChanged(_:)),
                                   for: .valueChanged)
        

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
            showMosqueLocations()
        case 1:
            showBankLocations()
        default:
            break
        }
    }
    
    func showMosqueLocations() {
        print("Mosques")
    }
    
    func showBankLocations() {
        print("Banks")
    }
}

//Map and Location Functionality
extension MapViewController: CLLocationManagerDelegate {
    enum PlaceType:String { case Mosque, Bank }
    
    private func getPlaceUrl(forType: PlaceType) -> String {
        return "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(userLocation.coordinate.latitude),\(userLocation.coordinate.latitude)&radius=5000&type=\(forType.rawValue)&key=\(GoogleApiKey)"
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
    
    func showMapLocation(location: CLLocation) {
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        marker.map = mapView

        mapView.camera = camera
        mapView.isHidden = false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
        
        manager.stopUpdatingLocation()
        
        showMapLocation(location: userLocation)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("\(error)")
    }
}

