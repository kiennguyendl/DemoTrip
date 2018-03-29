//
//  BaseCollectionViewLayout.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 3/26/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit

class BaseCollectionViewLayout: UICollectionViewLayout {
    
    private var _layoutMap = [IndexPath: UICollectionViewLayoutAttributes]()
    private var headerAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    private var _collumnsYOffset : [CGFloat]!
//    private var _collumnsYOffset1 : [CGFloat]!
//    private var _collumnsYOffset2 : [CGFloat]!
    private var _contentSize: CGSize!
    private(set) var totalItemsInSection = 0
//    private(set) var totalSections = 0

    var totalCollums = 0
//    var totalCollums1 = 0
//    var totalCollums2 = 0
    var itemSpacing : CGFloat = 10
    var count = 0
    
    var contentInsets: UIEdgeInsets{
        return collectionView!.contentInset
    }
    override var collectionViewContentSize: CGSize{
        return _contentSize
    }
    
    override func prepare() {
        _layoutMap.removeAll()
        headerAttributes.removeAll()
        _collumnsYOffset = Array(repeating: 0, count: totalCollums)
//        _collumnsYOffset1 = Array(repeating: 0, count: totalCollums1)
//        _collumnsYOffset2 = Array(repeating: 0, count: totalCollums2)

        totalItemsInSection = collectionView!.numberOfItems(inSection: 0)
        
        let headerIndexPath = IndexPath(item: 0, section: 0)
        
        let headerCellAttributes =
            UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: headerIndexPath)
        
        headerAttributes[headerIndexPath] = headerCellAttributes
        
        headerCellAttributes.frame = CGRect(x: 0, y: 0, width: collectionView!.frame.width, height: collectionView!.frame.width * 0.4)
        
        headerAttributes[headerIndexPath] = headerCellAttributes
        
        if totalItemsInSection > 0 && totalCollums > 0{
            self.calculateItemsSize()
            
            var itemIndex = 0
            var contentSizeHeight: CGFloat = 0

            _collumnsYOffset[0] = (collectionView?.frame.width)! * 0.4 + itemSpacing
            _collumnsYOffset[1] = (collectionView?.frame.width)! * 0.4 + itemSpacing
            
            while itemIndex < totalItemsInSection{
                
                let indexPath = IndexPath(item: itemIndex, section: 0)
                let collumnIndex = self.collumnIndexForItemAt(indexPath: indexPath)
                
                print("item: \(itemIndex) -------- collumn index: \(collumnIndex)")
//                let indexPath = IndexPath(item: itemIndex, section: 0)
//                let columnIndex = self.columnIndexForItemAt(indexPath: indexPath)
                
                let attributeRect = calculateItemFrame(indexPath: indexPath, columnIndex: collumnIndex, columnYoffset: _collumnsYOffset[collumnIndex], indexItem: count)
                let targetLayoutAttributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
                targetLayoutAttributes.frame = attributeRect

                contentSizeHeight = max(attributeRect.maxY, contentSizeHeight)
                _collumnsYOffset[collumnIndex] = attributeRect.maxY + itemSpacing
                _layoutMap[indexPath] = targetLayoutAttributes
                
                
                
                
//                if count == 0{
//                    var attributeRect = CGRect.zero
//                    _collumnsYOffset0[collumnIndex] = _collumnsYOffset2[collumnIndex]
//                    attributeRect = self.calculateItemFrame(indexPath: indexPath, columnIndex: collumnIndex, columnYoffset: _collumnsYOffset0[collumnIndex])
//
//                    let targetLayoutAttributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
//                    targetLayoutAttributes.frame = attributeRect
//
//                    contentSizeHeight = max(attributeRect.maxY, contentSizeHeight)
//                    _collumnsYOffset0[collumnIndex] = attributeRect.maxY
//                    _layoutMap[indexPath] = targetLayoutAttributes
//
//
//                }else if count > 0 && count < 4{
//                    var attributeRect = CGRect.zero
//                    if count == 1 || count == 3{
//
//                        _collumnsYOffset1[collumnIndex] = _collumnsYOffset0[0]
//                        attributeRect = self.calculateItemFrame(indexPath: indexPath, columnIndex: collumnIndex, columnYoffset: _collumnsYOffset1[collumnIndex])
//                    }else{
//                        _collumnsYOffset1[collumnIndex] = _collumnsYOffset1[0]
//                        attributeRect = self.calculateItemFrame(indexPath: indexPath, columnIndex: collumnIndex, columnYoffset: _collumnsYOffset1[collumnIndex])
//                    }
//
//                    let targetLayoutAttributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
//                    targetLayoutAttributes.frame = attributeRect
//
//                    contentSizeHeight = max(attributeRect.maxY, contentSizeHeight)
//                    _collumnsYOffset1[collumnIndex] = attributeRect.maxY + itemSpacing
//                    _layoutMap[indexPath] = targetLayoutAttributes
//                }else{
//                    var attributeRect = CGRect.zero
//                    _collumnsYOffset2[collumnIndex] = _collumnsYOffset1[collumnIndex]
//                    attributeRect = self.calculateItemFrame(indexPath: indexPath, columnIndex: collumnIndex, columnYoffset: _collumnsYOffset2[collumnIndex])
//
//                    let targetLayoutAttributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
//                    targetLayoutAttributes.frame = attributeRect
//
//                    contentSizeHeight = max(attributeRect.maxY, contentSizeHeight)
//                    _collumnsYOffset2[collumnIndex] = attributeRect.maxY
//                    _layoutMap[indexPath] = targetLayoutAttributes
//                }
                
                count += 1
                if count > 5{
                    count = 0
                }
                
                itemIndex += 1
            }
            
            _contentSize = CGSize(width: collectionView!.bounds.width - contentInsets.left - contentInsets.right, height: contentSizeHeight)
        }
        
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return headerAttributes[indexPath]
    }
    

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        var layoutAttributesArray = [UICollectionViewLayoutAttributes]()

        var attributes = [UICollectionViewLayoutAttributes](_layoutMap.values)
        attributes += [UICollectionViewLayoutAttributes](headerAttributes.values)

//        for (_, layoutAttributes) in _layoutMap {
//            if rect.intersects(layoutAttributes.frame) {
//                layoutAttributesArray.append(layoutAttributes)
//            }
//        }
        return attributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return _layoutMap[indexPath]
    }
    
    //Abstract method
    func collumnIndexForItemAt(indexPath: IndexPath) -> Int {
        return indexPath.item % totalCollums
    }
    
    func calculateItemFrame(indexPath: IndexPath, columnIndex: Int, columnYoffset: CGFloat, indexItem: Int) -> CGRect {
        return CGRect.zero
    }
    
    func calculateItemsSize() {}
}
