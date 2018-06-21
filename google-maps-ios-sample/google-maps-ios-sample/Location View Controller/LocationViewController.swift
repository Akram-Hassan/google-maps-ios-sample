import UIKit
import CoreLocation
import GoogleMaps
import Alamofire
import SwiftyJSON

class LocationViewController: UIViewController {
    var mapView : GMSMapView!
    var model: LocationModel!

    private func getDirectionsUrl(forType: DirectionMode) -> String {
        return "https://maps.googleapis.com/maps/api/directions/json?origin=\(model.userLocation.latitude),\(model.userLocation.longitude)&destination=\(model.destination.latitude),\(model.destination.longitude)&mode=\(forType.rawValue.lowercased())&key=AIzaSyD-nIE6fQ4k7oCfLtIIKvMOgRpwU9X0LcA"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showDirections(forType: .Driving)
        showDirections(forType: .Walking)
    }
    

    private func setupMap() {
        mapView = GMSMapView(frame: CGRect.zero)
        let camera = GMSCameraPosition.camera(withLatitude: model.userLocation.latitude,
                                              longitude: model.userLocation.longitude,
                                              zoom: zoomLevel)
        mapView.camera = camera

        view = mapView
    }
    
    func showDirections(forType: DirectionMode)  {
        mapView.clear()
        
        let webServiceUrl = getDirectionsUrl(forType: forType)
        Alamofire.request(webServiceUrl)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let parsedData = JSON(data)
                    let path = GMSPath.init(fromEncodedPath: parsedData["routes"][0]["overview_polyline"]["points"].string!)
                    let singleLine = GMSPolyline.init(path: path)
                    singleLine.strokeWidth = 6
                    singleLine.strokeColor = forType == .Walking ? .green : .red
                    singleLine.map = self.mapView
                    
                case .failure(let error):
                    print(error)
                }
        }
    }
}
