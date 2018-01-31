//
//  MeetingPointTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/7/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit
import MapKit

protocol MeetingPointTableViewCellProtocol {
    func presentMapView()
}

class MeetingPointTableViewCell: UITableViewCell {


    @IBOutlet weak var mapMeetingPoint: MKMapView!
    var delegate: MeetingPointTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()

        mapMeetingPoint.delegate = self
        let location = CLLocationCoordinate2D(latitude: 10.768376, longitude: 106.666808)
        let spanOfMap = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.025)
        let region = MKCoordinateRegion(center: location, span: spanOfMap)
        mapMeetingPoint.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = location
        pin.title = "Where we'll meet"
        pin.subtitle = "District 10, HCM City"
        mapMeetingPoint.addAnnotation(pin)
        mapMeetingPoint.selectedAnnotations = [pin]
        mapMeetingPoint.isScrollEnabled = false
        mapMeetingPoint.isZoomEnabled = false
        mapMeetingPoint.isUserInteractionEnabled = false
    }
    
    @IBAction func goToMapViewBtn(_ sender: Any) {
        self.delegate?.presentMapView()
    }
    
}

extension MeetingPointTableViewCell: MKMapViewDelegate{
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

