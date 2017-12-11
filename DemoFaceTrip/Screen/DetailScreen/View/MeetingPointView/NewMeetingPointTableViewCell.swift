//
//  NewMeetingPointTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/8/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit
import GoogleMaps

class NewMeetingPointTableViewCell: UITableViewCell {

//    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var view: UIView!
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
    
    var googleMapsView:GMSMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

//        let location = CLLocationCoordinate2D(latitude: 10.757300, longitude: 106.659722)
//        let camera = GMSCameraPosition.camera(withLatitude: 10.757300, longitude: 106.659722, zoom: 15)
//        self.googleMapsView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), camera: camera)
//        self.googleMapsView.camera = camera
//        self.googleMapsView.isMyLocationEnabled = true
//        self.addSubview(googleMapsView)
//        let marker =  GMSMarker(position: location)
//        marker.title = "When we'll meet"
//        marker.snippet = "Cho Ray Hopital, Distric 5, HCM City"
//        marker.map = self.googleMapsView
//        self.googleMapsView.selectedMarker = marker
//        self.googleMapsView.isUserInteractionEnabled = false

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension NewMeetingPointTableViewCell: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        DispatchQueue.main.async {
            let location = CLLocationCoordinate2D(latitude: self.latitue, longitude: self.longtitue)
            let camera = GMSCameraPosition.camera(withLatitude: self.latitue, longitude: self.longtitue, zoom: 15)
            self.googleMapsView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), camera: camera)
            self.googleMapsView.camera = camera
            self.googleMapsView.isMyLocationEnabled = true
            self.view.addSubview(self.googleMapsView)
            let marker =  GMSMarker(position: location)
            marker.groundAnchor = CGPoint(x: 0.5, y: 0.3)
            marker.title = "When we'll meet"
            if let meetingPoint = self.meetingPoint{
                marker.snippet = meetingPoint
            }
            marker.icon = self.imageWithImage(image: UIImage(named: "marker")!, scaledToSize: CGSize(width: 40.0, height: 40.0))
            marker.map = self.googleMapsView
            self.googleMapsView.selectedMarker = marker
            self.googleMapsView.isUserInteractionEnabled = false
            self.locationManager.stopUpdatingLocation()
        }
       
    }
    
}
