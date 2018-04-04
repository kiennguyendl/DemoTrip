//
//  PickATagCustomLayoutV2.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 4/2/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

//
//  PickATagCustomLayout.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 3/26/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit

//private let kNumberOfSideItemRow0 = 2
//private let kNumberOfSideItemRow1 = 2
//private let kNumberOfSideItemRow2 = 2

private let kSideItemWidthCoef: CGFloat = 0.4
private let kSideItemHeightAspect: CGFloat = 1
private let kNumberOfSideItems = 2

class PickATagCustomLayoutV2: BaseCollectionViewLayout {
    
    private var _itemSize: CGSize!
    private var _mainItemSize1: CGSize!
    private var _mainItemSize2: CGSize!
    
    private var _itemSizeRow1: CGSize!
    private var _mainItemSizeRow1: CGSize!
    
    
    private var _collumnXOffset: [CGFloat]!
    //    private var _collumnXOffset1: [CGFloat]!
    //    private var _collumnXOffset2: [CGFloat]!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.totalCollums = 2
        //        self.totalCollums1 = 2
        //        self.totalCollums2 = 2
    }
    
    override var description: String{
        return ""
    }
    
    override func collumnIndexForItemAt(indexPath: IndexPath) -> Int {

//        let totalItemsInRow = kNumberOfSideItems + 1
//        let columnIndex = indexPath.item % totalItemsInRow
//        let columnIndexLimit = totalCollums - 1

        if count == 1 || count == 5{

            if count == 1{
                return 1
            }else{
                return 0
            }
        }else if count == 3 || count == 9{
            if count == 3{
                return 0
            }else{
                return 1
            }
        }else{
            if count == 0 || count == 2 || count == 8{
                return 0
            }else{
                return 1
            }
            
        }

    }
    
    override func calculateItemFrame(indexPath: IndexPath, columnIndex: Int, columnYoffset: CGFloat, indexItem: Int) -> CGRect {
        if indexItem == 1 || indexItem == 5{
            let size = _mainItemSize1

            if count == 1{
                let rect = CGRect(origin: CGPoint(x: _collumnXOffset[1], y: columnYoffset), size: size!)
                print("rect: \(rect)")
                return rect
            }else{
                let rect = CGRect(origin: CGPoint(x: _collumnXOffset[0], y: columnYoffset), size: size!)
                print("rect: \(rect)")
                return rect
            }
            
        }else if count == 3 || count == 9{
            let size = _mainItemSize2
            if count == 3{
                let rect = CGRect(origin: CGPoint(x: _collumnXOffset[0], y: columnYoffset), size: size!)
                print("rect: \(rect)")
                return rect
            }else{
                let rect = CGRect(origin: CGPoint(x: _collumnXOffset[3], y: columnYoffset), size: size!)
                print("rect: \(rect)")
                return rect
            }
        }else{
            let size = _itemSize
            if count == 2 || count == 0 || count == 8{
                let rect = CGRect(origin: CGPoint(x: _collumnXOffset[0], y: columnYoffset), size: size!)
                print("rect: \(rect)")
                return rect
            }else{
                let rect = CGRect(origin: CGPoint(x: _collumnXOffset[2], y: columnYoffset), size: size!)
                print("rect: \(rect)")
                return rect
            }
        }
    }
    
    override func calculateItemsSize() {
        
        let floatNumberOfSideItems = CGFloat(kNumberOfSideItems)
        let contentWidthWithoutIndents = collectionView!.bounds.width - contentInsets.left - contentInsets.right
        let resolvedContentWidth = contentWidthWithoutIndents - itemSpacing
        
        // We need to calculate side item size first, in order to calculate main item height
        let sideItemWidth = resolvedContentWidth * kSideItemWidthCoef
        let sideItemHeight = sideItemWidth * kSideItemHeightAspect
        
        _itemSize = CGSize(width: sideItemWidth, height: sideItemHeight)
        
        // Now we can calculate main item height
        let mainItemWidth = resolvedContentWidth - sideItemWidth
        let mainItemHeight = sideItemHeight * floatNumberOfSideItems + ((floatNumberOfSideItems - 1) * itemSpacing)
        
        _mainItemSize1 = CGSize(width: mainItemWidth, height: mainItemHeight)
        _mainItemSize2 = CGSize(width: mainItemWidth, height: sideItemHeight)
        
        // Calculating offsets by X for each column
        _collumnXOffset = [0, _itemSize.width + itemSpacing, _mainItemSize1.width + itemSpacing, _mainItemSize2.width + itemSpacing]

        
    }
}

