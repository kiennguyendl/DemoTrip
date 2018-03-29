//
//  PickATagViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 3/23/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit

let listTypeTrip = ["TRAVEL", "GETWAY", "LOVE", "DAILY LIFE", "LONELY", "OTHER"]

class PickATagViewController: UIViewController {

    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var listTypeTagCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func setupLayout() {
        exitBtn.layer.cornerRadius = exitBtn.frame.width / 2
        exitBtn.layer.masksToBounds = true
        
        listTypeTagCollectionView.delegate = self
        listTypeTagCollectionView.dataSource = self
        listTypeTagCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        listTypeTagCollectionView.register(UINib.init(nibName: "PickATagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pickATagCell")
        listTypeTagCollectionView.register(UINib.init(nibName: "PickATagCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "pickATagHeader")
//        listTypeTagCollectionView.register(PickATagCollectionReusableView.self,
//                                          forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
//                                          withReuseIdentifier: "pickATagHeader")
    }

    @IBAction func exit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension PickATagViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0{
//            return 1
//        }else{
            return listTypeTrip.count - 1
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pickATagCell", for: indexPath) as! PickATagCollectionViewCell
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true

        cell.typeTagLbl.text = listTypeTrip[indexPath.item + 1]

        return cell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.listTypeTagCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        let width = collectionView.frame.width
        let height = width / 3

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader{
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "pickATagHeader", for: indexPath) as! PickATagCollectionReusableView
            headerView.layer.cornerRadius = 5
            headerView.clipsToBounds = true
            return headerView
        }else{
            return UICollectionReusableView()
        }
    }
}
