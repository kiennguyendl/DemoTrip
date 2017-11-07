//
//  MapViewViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/7/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit
import MapKit

class MapViewViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var delegate: MeetingPointTableViewCellProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        let location = CLLocationCoordinate2D(latitude: 10.768376, longitude: 106.666808)
        let spanOfMap = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: spanOfMap)
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = location
        pin.title = "Where we'll meet"
        pin.subtitle = "District 10, HCM City"
        mapView.addAnnotation(pin)
        mapView.selectedAnnotations = [pin]
        //mapView.isUserInteractionEnabled = false
    }

    @IBAction func dismissViewBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension MapViewViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let identifier = "MyCustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
}
