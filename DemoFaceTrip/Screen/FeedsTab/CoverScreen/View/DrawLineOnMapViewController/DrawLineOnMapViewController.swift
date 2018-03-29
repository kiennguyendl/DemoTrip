//
//  DrawLineOnMapViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 3/27/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import Photos
//CLLocationCoordinate2D(latitude: latitude2, longitude: longitude2)
let arrayPossition = [CLLocationCoordinate2D(latitude: 10.778118, longitude: 106.695494),
                      CLLocationCoordinate2D(latitude: 10.940179, longitude: 108.184201),
                      CLLocationCoordinate2D(latitude: 12.273550, longitude: 109.195769),
                      CLLocationCoordinate2D(latitude: 16.045351, longitude: 108.227991),
                      CLLocationCoordinate2D(latitude: 18.672984, longitude: 105.674153),
                      CLLocationCoordinate2D(latitude: 21.024987, longitude: 105.841138)]

class DrawLineOnMapViewController: BaseViewController {

    @IBOutlet weak var mapView: UIView!
    var googleMap: GMSMapView!
    var locationManager = CLLocationManager()
    var clusterManager: GMUClusterManager!
    var listAsset: [AsssetInfor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLeftRightButton()
        settingMap()
        
    }

    override func viewWillLayoutSubviews() {
//        googleMap.frame = self.view.frame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        googleMap.frame = CGRect(x: 0, y: 0, width: mapView.frame.width, height: mapView.frame.height)
    }
    
    func initLeftRightButton() {
        let cancelButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelEditPost))
        navigationItem.leftBarButtonItem = cancelButton
        
        let postButton: UIBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextStep))
        navigationItem.rightBarButtonItem = postButton
    }
    
    @objc func cancelEditPost() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func nextStep() {
        
    }
    
    func settingMap() {
        let camera = GMSCameraPosition.camera(withLatitude: arrayPossition[0].latitude, longitude: arrayPossition[0].longitude, zoom: 10)
        googleMap = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: mapView.frame.width, height: mapView.frame.height), camera: camera)
        googleMap.camera = camera
        self.mapView.addSubview(googleMap)
        mapView.layoutIfNeeded()
        
        autoZoomMap()
        
        initClusters()
        
        drawLine()
    }
    
    func autoZoomMap() {
        var bounds = GMSCoordinateBounds()
        for pos in arrayPossition{
            bounds = bounds.includingCoordinate(pos)
        }
        
        let update = GMSCameraUpdate.fit(bounds)
        googleMap.moveCamera(update)
    }

    func initClusters() {
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: googleMap, clusterIconGenerator: iconGenerator)
        renderer.delegate = self
        clusterManager = GMUClusterManager(map: googleMap, algorithm: algorithm, renderer: renderer)
        createClusterItem()
        clusterManager.cluster()
        clusterManager.setDelegate(self, mapDelegate: self)
    }
    
    func createClusterItem() {
        
        var images = [UIImage]()
        for asset in listAsset{
            PHImageManager.default().requestImage(for: asset.asset!, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
                
                images.append(image!)
            })
        }
        
        for pos in arrayPossition{
            let item = PointItem(position: pos, images: images)
            clusterManager.add(item)
        }
    }
    
    func drawLine() {
        var path = GMSMutablePath()
        
        for pos in arrayPossition{
            path.add(pos)
        }
        
        let line = GMSPolyline(path: path)
        line.strokeWidth = 2.0
        line.strokeColor = .red
        line.map = googleMap
    }
    
    @IBAction func dismissView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension DrawLineOnMapViewController: GMUClusterManagerDelegate, GMSMapViewDelegate, GMUClusterRendererDelegate{
    
    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        return true
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let vc = ListImageViewController()
        vc.listAsset = listAsset
        navigationController?.pushViewController(vc, animated: true)
        return true
    }
    
    func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
        
        let item = marker.userData as! PointItem
        
        let randomIndex = Int(arc4random_uniform(UInt32(item.images.count)))
        let image = item.images[randomIndex]
        
        let markerView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 100)))
        markerView.backgroundColor = .clear
        
        let markerImage = UIImageView(frame: CGRect(x: 25, y: 25, width: 60, height: 60))
        markerImage.image = UIImage(named: "infowindow")
        
        let imgInside = UIImageView(frame: CGRect(x: 30, y: 30, width: 50, height: 45))
        imgInside.image = image
        
        let label = UILabel(frame: CGRect(x: 65, y: 15, width: 20, height: 20))
        label.text = "\(item.images.count)"
        label.font = UIFont.systemFont(ofSize: 10)
        label.backgroundColor = UIColor(red: 77/255, green: 153/255, blue: 255/255, alpha: 1)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = label.frame.width / 2
        label.layer.masksToBounds = true
        
        markerView.addSubview(markerImage)
        markerView.addSubview(imgInside)
        markerView.addSubview(label)
        
        UIGraphicsBeginImageContextWithOptions(markerView.frame.size, false, UIScreen.main.scale)
        markerView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageConverted: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        marker.icon = imageConverted
        marker.groundAnchor = CGPoint(x: 0.55, y: 0.85)
    }
}
