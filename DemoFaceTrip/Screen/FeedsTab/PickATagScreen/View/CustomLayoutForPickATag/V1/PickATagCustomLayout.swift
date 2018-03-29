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

class PickATagCustomLayout: BaseCollectionViewLayout {

    private var _itemSize: CGSize!
    private var _mainItemSize: CGSize!
    
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
//        if count == 0{
//            let totalItemsInRow = kNumberOfSideItemRow0 + 1
//            let columnIndex = indexPath.item % totalItemsInRow
//            let columnIndexLimit = totalCollums0 - 1
//            return columnIndex > columnIndexLimit  ? columnIndexLimit : columnIndex
//        }else if count > 0 && count < 4{
//            let totalItemsInRow = kNumberOfSideItemRow1 + 1
//            let columnIndex = indexPath.item % totalItemsInRow
//            let columnIndexLimit = totalCollums1 - 1
//            return columnIndex > columnIndexLimit  ? columnIndexLimit : columnIndex
//        }else{
//            let totalItemsInRow = kNumberOfSideItemRow2 + 1
//            let columnIndex = indexPath.item % totalItemsInRow
//            let columnIndexLimit = totalCollums2 - 1
//            return columnIndex > columnIndexLimit  ? columnIndexLimit : columnIndex
//        }
        
        
        let totalItemsInRow = kNumberOfSideItems + 1
        let columnIndex = indexPath.item % totalItemsInRow
        let columnIndexLimit = totalCollums - 1
//        print("columnIndex: \(columnIndex) ------- columnIndexLimit: \(columnIndexLimit)----- count: \(count)")
        
//        if columnIndex == 0 || columnIndex == 2{
        if count == 1 || count == 3{
//                return 0
//            }else{
//                return 1
//            }
            if count == 1{
                return 1
            }else{
                return 0
            }
        }else{
//            if count == 1{
//                return 1
//            }else{
//                return 0
            if count == 2 || count == 0{
                return 0
            }else{
                return 1
            }
        }
            
//        }
    
//        let colum = columnIndex > columnIndexLimit  ? columnIndexLimit : columnIndex
//        print("Collumn: \(colum)---indexPath: \(indexPath)")
//
//        return colum
    }
    
    override func calculateItemFrame(indexPath: IndexPath, columnIndex: Int, columnYoffset: CGFloat, indexItem: Int) -> CGRect {
        if indexItem == 1 || indexItem == 3{
            let size = _mainItemSize

//            let rect = CGRect(origin: CGPoint(x: _collumnXOffset[columnIndex], y: columnYoffset), size: size!)
//            print("rect: \(rect)")
//            return rect

            if count == 1{
                let rect = CGRect(origin: CGPoint(x: _collumnXOffset[1], y: columnYoffset), size: size!)
                print("rect: \(rect)")
                return rect
//                return 1
            }else{
                let rect = CGRect(origin: CGPoint(x: _collumnXOffset[0], y: columnYoffset), size: size!)
                print("rect: \(rect)")
                return rect
//                return 0
            }
            
        }else{
            let size = _itemSize
//            return CGRect(origin: CGPoint(x: _collumnXOffset0[columnIndex], y: columnYoffset), size: size!)
//            let rect = CGRect(origin: CGPoint(x: _collumnXOffset[columnIndex], y: columnYoffset), size: size!)
//            print("rect: \(rect)")
//            return rect
            
            if count == 2 || count == 0{
//                return 0
                let rect = CGRect(origin: CGPoint(x: _collumnXOffset[0], y: columnYoffset), size: size!)
                print("rect: \(rect)")
                return rect
            }else{
//                return 1
                let rect = CGRect(origin: CGPoint(x: _collumnXOffset[2], y: columnYoffset), size: size!)
                print("rect: \(rect)")
                return rect
            }
        }
        
        
        
//        if count == 0{
//            let size = _itemSizeRow0
//            return CGRect(origin: CGPoint(x: _collumnXOffset0[columnIndex], y: columnYoffset), size: size!)
//        }else if count > 0 && count < 4{
//            if count == 3{
//                let size = _mainItemSizeRow1
//                return CGRect(origin: CGPoint(x: _collumnXOffset1[columnIndex], y: columnYoffset), size: size!)
//            }else{
//                let size = _itemSizeRow1
//                return CGRect(origin: CGPoint(x: _collumnXOffset1[columnIndex], y: columnYoffset), size: size!)
//            }
//        }else{
//            if count == 4{
//                let size = _mainItemSizeRow2
//                return CGRect(origin: CGPoint(x: _collumnXOffset1[columnIndex], y: columnYoffset), size: size!)
//            }else{
//                let size = _itemSizeRow2
//                return CGRect(origin: CGPoint(x: _collumnXOffset1[columnIndex], y: columnYoffset), size: size!)
//            }
//        }
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
        
        _mainItemSize = CGSize(width: mainItemWidth, height: mainItemHeight)
        
        // Calculating offsets by X for each column
        _collumnXOffset = [0, _itemSize.width + itemSpacing, _mainItemSize.width + itemSpacing]
//        _collumnXOffset1 = [0, _mainItemSize.width + itemSpacing]
        
//        let contentWidthWithoutIndents = collectionView!.bounds.width - contentInsets.left - contentInsets.right

//            let floatNumberOfSideItems0 = CGFloat(kNumberOfSideItemRow0)
//            let resolvedContentWidth0 = contentWidthWithoutIndents
//            let sideItemWidth = resolvedContentWidth0
//            let sideItemHeight = sideItemWidth / 3
//
//            _itemSizeRow0 = CGSize(width: sideItemWidth, height: sideItemHeight)
//            _collumnXOffset0 = [0]
//
//
//            let floatNumberOfSideItems1 = CGFloat(kNumberOfSideItemRow1)
//            let resolvedContentWidth1 = contentWidthWithoutIndents - itemSpacing
//
//            let sideItemWidth1 = resolvedContentWidth1 / 3
//            let sideItemHeight1 = sideItemWidth
//
//            _itemSizeRow1 = CGSize(width: sideItemWidth1, height: sideItemHeight1)
//
//            let mainItemWidth1 = resolvedContentWidth1 - sideItemWidth1
//            let mainItemHeight1 = sideItemHeight1 * floatNumberOfSideItems1 + ((resolvedContentWidth1 - 1) * itemSpacing)
//            _mainItemSizeRow1 = CGSize(width: mainItemWidth1, height: mainItemHeight1)
//
//            _collumnXOffset1 = [0, _itemSizeRow1.width + itemSpacing]
//
//            let floatNumberOfSideItems2 = CGFloat(kNumberOfSideItemRow2)
//            let resolvedContentWidth2 = contentWidthWithoutIndents - itemSpacing
//
//            let sideItemWidth2 = resolvedContentWidth2 / 3
//            let sideItemHeight2 = sideItemWidth
//
//            _itemSizeRow2 = CGSize(width: sideItemWidth2, height: sideItemHeight2)
//
//            let mainItemWidth2 = resolvedContentWidth2 - sideItemWidth2
//            let mainItemHeight2 = sideItemHeight2
//            _mainItemSizeRow2 = CGSize(width: mainItemWidth2, height: mainItemHeight2)
//
//            _collumnXOffset2 = [0, _mainItemSizeRow2.width + itemSpacing]
        
    }
}
