//
//  NewMapViewViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/8/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class NewMapViewViewController: BaseViewController {

    @IBOutlet weak var dismissBtn: UIButton!
    var googleMapsView:GMSMapView!
    var locationManager = CLLocationManager()
    
    var meetingPoint: String?
    var coordination: Coordination?{
        didSet{
            if let coordination = coordination{
                if let lat = coordination.latitude{
                    latitue = lat
                }
                
                if let long = coordination.longtitue{
                    longtitue = long
                }
                
            }
        }
    }
    var latitue: Double!
    var longtitue: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        let location = CLLocationCoordinate2D(latitude: self.latitue, longitude: self.longtitue)
        let camera = GMSCameraPosition.camera(withLatitude: self.latitue, longitude: self.longtitue, zoom: 15)
        self.googleMapsView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), camera: camera)
        self.googleMapsView.camera = camera
        self.googleMapsView.isMyLocationEnabled = true
        self.googleMapsView.settings.compassButton = true
        self.view.addSubview(googleMapsView)
        self.view.bringSubview(toFront: dismissBtn)
        
        let marker =  GMSMarker(position: location)
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.3)
        marker.title = "When we'll meet"
        if let meetingPoint = meetingPoint{
            marker.snippet = meetingPoint
        }
        marker.icon = self.imageWithImage(image: UIImage(named: "marker")!, scaledToSize: CGSize(width: 40.0, height: 40.0))
        marker.map = self.googleMapsView
        self.googleMapsView.selectedMarker = marker
        
        let myLocation = locationManager.location?.coordinate
        drawPath(startLocation: myLocation!, endLocation: location)
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    @IBAction func dismissMapView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func drawPath(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D)
    {
        let origin = "\(startLocation.latitude),\(startLocation.longitude)"
        let destination = "\(endLocation.latitude),\(endLocation.longitude)"
        
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        
        Alamofire.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            
            let json = JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            
            // print route using Polyline
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeWidth = 5
                polyline.strokeColor = UIColor.blue
                polyline.map = self.googleMapsView
            }
            
        }
    }
}

extension NewMapViewViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = CLLocationCoordinate2D(latitude: 10.757300, longitude: 106.659722)
//        let camera = GMSCameraPosition.camera(withLatitude: 10.757300, longitude: 106.659722, zoom: 15)
//        self.googleMapsView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), camera: camera)
//        self.googleMapsView.camera = camera
//        self.googleMapsView.isMyLocationEnabled = true
//        self.view.addSubview(googleMapsView)
//        self.view.bringSubview(toFront: dismissBtn)
//        let marker =  GMSMarker(position: location)
//        marker.title = "When we'll meet"
//        marker.snippet = "Cho Ray Hopital, Distric 5, HCM City"
//        marker.map = self.googleMapsView
//        self.googleMapsView.selectedMarker = marker
        locationManager.stopUpdatingLocation()
    }
    
}
