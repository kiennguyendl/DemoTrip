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
    var dictAssetByLocaiton = [CLLocationCoordinate2D: [AsssetInfor]]()
    var listAsset: [AsssetInfor]!{
        didSet{
            dictAssetByLocaiton = ImagesManager.shareInstance.groupdImagesByLocation(listAsset: listAsset)
        }
    }
    
    var delegate: EditCoverProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()

        initLeftRightButton(titleLeft: "Cancel", titleRight: "Next")
        settingMap()
        
    }

    override func viewWillLayoutSubviews() {
//        googleMap.frame = self.view.frame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        setNoneColorForNavigation()
        mapView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        googleMap.frame = CGRect(x: 0, y: 0, width: mapView.frame.width, height: mapView.frame.height)
    }
    
//    override func initLeftRightButton() {
//        let cancelButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelEditPost))
//        navigationItem.leftBarButtonItem = cancelButton
//        
//        let postButton: UIBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextStep))
//        navigationItem.rightBarButtonItem = postButton
//    }
//    
    override func leftButton() {
        delegate?.playSlideShow()
        navigationController?.popViewController(animated: true)
    }
    override func rightButton() {
        
    }
    
    
    func settingMap() {
        var locations = [CLLocationCoordinate2D]()
        for (k,v) in dictAssetByLocaiton{
            locations.append(k)
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: locations[0].latitude, longitude: locations[0].longitude, zoom: 10)
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
        for key in dictAssetByLocaiton.keys{
            bounds = bounds.includingCoordinate(CLLocationCoordinate2D(latitude: key.latitude, longitude: key.longitude))
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
        
        var arrayKey = Array(dictAssetByLocaiton.keys)
        
        for (key,value) in dictAssetByLocaiton{
            
            let pos = CLLocationCoordinate2D(latitude: key.latitude, longitude: key.longitude)
            
//            var images = [UIImage]()
//            for asset in value{
//                PHImageManager.default().requestImage(for: asset.asset!, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
//
//                    images.append(image!)
//                })
//            }
            var item: PointItem!
            if key == arrayKey.first{
                item = PointItem(position: pos, listAsset: value, startPoint: true, endPoint: false)
            }else if key == arrayKey.last{
                item = PointItem(position: pos, listAsset: value, startPoint: false, endPoint: true)
            }else{
                item = PointItem(position: pos, listAsset: value, startPoint: false, endPoint: false)
            }
            
            clusterManager.add(item)
        }
    }
    
    func drawLine() {
        var path = GMSMutablePath()
        
        for key in dictAssetByLocaiton.keys{
            path.add(CLLocationCoordinate2D(latitude: key.latitude, longitude: key.longitude))
        }
        
        let line = GMSPolyline(path: path)
        line.strokeWidth = 2.0
        line.strokeColor = UIColor(red: 77/255, green: 153/255, blue: 255/255, alpha: 1)
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
        let item = marker.userData as! PointItem
        let listAsset = item.listAsset
        vc.listAsset = listAsset
        navigationController?.pushViewController(vc, animated: true)
        return true
    }
    
    func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
        
        guard let item = marker.userData as? PointItem else{return}
//        print("location: \(item.position.latitude) + \(item.position.longitude)")
        let listAsset = item.listAsset
        
        var images = [UIImage]()
        for asset in listAsset{
            PHImageManager.default().requestImage(for: asset.asset!, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
                
                images.append(image!)
            })
        }
        
//        let randomIndex = Int(arc4random_uniform(UInt32(item.images.count)))
        let image = images[0]
        
        let markerView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 100)))
        markerView.backgroundColor = .clear
        
        let markerImage = UIImageView(frame: CGRect(x: 25, y: 25, width: 60, height: 60))
        markerImage.image = UIImage(named: "infowindow")
        
        let imgInside = UIImageView(frame: CGRect(x: 30, y: 30, width: 50, height: 45))
        imgInside.image = image
        
        let label = UILabel(frame: CGRect(x: 65, y: 15, width: 30, height: 20))
        label.text = "\(images.count)"
        label.font = UIFont.systemFont(ofSize: 10)
        label.backgroundColor = UIColor(red: 77/255, green: 153/255, blue: 255/255, alpha: 1)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = label.frame.height / 2
        label.layer.masksToBounds = true
        
        let startOrEndPointImage = UIImageView(frame: CGRect(x: 48, y: 78, width: 15, height: 15))
        startOrEndPointImage.image = UIImage(named: "marker")?.withRenderingMode(.alwaysTemplate)
        startOrEndPointImage.isHidden = true

        if item.startPoint == true{
            startOrEndPointImage.isHidden = false
            startOrEndPointImage.tintColor = .green
        }else if item.endPoint == true{
            startOrEndPointImage.isHidden = false
            startOrEndPointImage.tintColor = .red
        }else{
            startOrEndPointImage.isHidden = true
        }
        
        
        markerView.addSubview(startOrEndPointImage)
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
