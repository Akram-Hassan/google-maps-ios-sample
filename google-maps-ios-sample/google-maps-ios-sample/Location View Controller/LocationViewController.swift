import UIKit
import CoreLocation
import GoogleMaps
import Alamofire

class LocationViewController: UIViewController {
    var locationManager:CLLocationManager!
    var mapView : GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    private func setupMap() {
        mapView = GMSMapView(frame: CGRect.zero)
        view = mapView
        mapView.isHidden = true
    }
}
