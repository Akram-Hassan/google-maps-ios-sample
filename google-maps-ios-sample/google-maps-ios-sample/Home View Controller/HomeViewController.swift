import UIKit
import CoreLocation
import GoogleMaps
import Alamofire

//High Level Functionlaity
class HomeViewController: UIViewController, GMSMapViewDelegate {

    var locationManager:CLLocationManager!
    var mapView : GMSMapView!
    
    let zoomLevel: Float = 12
    let radius = 5000
    
    var loaded: Bool = false
    
    var model = Home()
    
    override func loadView() {
        setupMap()
        setupSegmentedControl()
    }
    
    private func setupMap() {
        mapView = GMSMapView(frame: CGRect.zero)
        mapView.delegate = self
        view = mapView
        mapView.isHidden = true
    }
    
    private func setupSegmentedControl() {
        let segmentedControl
            = UISegmentedControl(items: ["Mosques", "Banks"])
        segmentedControl.backgroundColor = UIColor.white
        
        segmentedControl.selectedSegmentIndex = 1
        
        segmentedControl.addTarget(self,
                                   action: #selector(HomeViewController.mapTypeChanged(_:)),
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
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if loaded == false {
            getCurrentLocationInfo()
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print(marker.position)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let locationVC = storyBoard.instantiateViewController(withIdentifier:"Location") as? LocationViewController
        self.navigationController?.pushViewController(locationVC!, animated: true)
        
        return true
    }
}

