import UIKit
import CoreLocation
import GoogleMaps
import Alamofire

class LocationViewController: UIViewController {
    var mapView : GMSMapView!
    var model: LocationModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
    }

    private func setupMap() {
        mapView = GMSMapView(frame: CGRect.zero)
        view = mapView
    }
}
