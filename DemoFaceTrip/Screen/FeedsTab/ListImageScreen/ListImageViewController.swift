//
//  ListImageViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 2/23/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit
import Photos

class ListImageViewController: BaseViewController {

    @IBOutlet weak var listImageCollectionView: UICollectionView!
    
    var listAsset = [AsssetInfor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Images"
        initLeftRightButton(titleLeft: "Back", titleRight: "")
        setDefaultColorForNavigation()
        listImageCollectionView.delegate = self
        listImageCollectionView.dataSource = self
        listImageCollectionView.register(UINib.init(nibName: "ImageOfSuggestionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageOfSuggestion")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = true
    }

    override func leftButton() {
        navigationController?.popViewController(animated: true)
    }
}

extension ListImageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listAsset.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageOfSuggestion", for: indexPath) as! ImageOfSuggestionCollectionViewCell
        
        let asset = listAsset[indexPath.row].asset
        
        PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
            
            cell.imageView.image = image
            cell.buttonView.isHidden = true
            cell.blurEffectView.isHidden = true
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 1
        
        return CGSize(width: width, height: width)
    }
}
