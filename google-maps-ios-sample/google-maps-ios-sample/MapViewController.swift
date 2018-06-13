import UIKit
import CoreLocation
import GoogleMaps

//High Level Functionlaity
class MapViewController: UIViewController {

    var locationManager:CLLocationManager!
    var userLocation:CLLocation!
    var mapView : GMSMapView!
    let zoomLevel: Float = 15
    
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
}

