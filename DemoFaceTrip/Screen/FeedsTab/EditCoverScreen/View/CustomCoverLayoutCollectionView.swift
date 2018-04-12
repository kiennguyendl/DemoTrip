//
//  CustomCoverLayoutCollectionView.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 4/4/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit

class CustomCoverLayoutCollectionView: UICollectionViewFlowLayout {
    var scalingOffset = CGFloat(0)
    var minimumScaleFactor = CGFloat(1)
    var scaleItems = false
    var lastCollectionViewSize: CGSize = CGSize.zero
    
    static func layoutConfiguredWithCollectionView(collectionView: UICollectionView, itemSize: CGSize, minimumLineSpacing: CGFloat) -> CustomCoverLayoutCollectionView{
        let layout = CustomCoverLayoutCollectionView()
        collectionView.collectionViewLayout = layout
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = minimumLineSpacing
        layout.itemSize = itemSize
        layout.headerReferenceSize = CGSize(width: 0,height: 0)
        layout.footerReferenceSize = CGSize(width: 0,height: 0)
        layout.collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
        
        return layout
    }
    
    override init() {
        super.init()
        configureDefaults()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureDefaults() {
        scalingOffset = 200
        minimumScaleFactor = 0.95
        scaleItems = true
    }
    
    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        super.invalidateLayout(with: context)
        
        if let currentCollectionViewSize = collectionView?.bounds.size{
            if !(currentCollectionViewSize.equalTo(lastCollectionViewSize)){
                configureInset()
                lastCollectionViewSize = currentCollectionViewSize
            }
        }
    }
    
    func configureInset() {
        let inset = (self.collectionView?.bounds.size.width)!/2 - self.itemSize.width/2
        self.collectionView?.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        self.collectionView?.contentOffset = CGPoint(x: -inset,y: 0)
    }
    
     public override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return CGPoint.zero
        }
        let collectionViewSize = collectionView.bounds.size
        let proposedContentOffsetCenterX = proposedContentOffset.x + (collectionViewSize.width / 2)
        
        let proposedRect = CGRect(x: proposedContentOffset.x,y: 0,width: collectionViewSize.width,height: collectionViewSize.height)
        var candidateAttributes = UICollectionViewLayoutAttributes()
        for attributes in self.layoutAttributesForElements(in: proposedRect)!{
            if (attributes.representedElementCategory != .cell){
                continue
            }
            if candidateAttributes != nil{
                candidateAttributes = attributes
                continue
            }
            
            if (fabs(attributes.center.x - proposedContentOffsetCenterX) < fabs(candidateAttributes.center.x - proposedContentOffsetCenterX)) {
                candidateAttributes = attributes
            }
        }
        
        var newOffsetX = candidateAttributes.center.x - collectionView.bounds.size.width / 2
        
        let offset = newOffsetX - collectionView.contentOffset.x
        
        
        if ((velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0)) {
            let pageWidth = self.itemSize.width + self.minimumLineSpacing;
            newOffsetX += velocity.x > 0 ? pageWidth : -pageWidth;
        }
        
        return CGPoint(x: newOffsetX,y: proposedContentOffset.y)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if !scaleItems{
            return super.layoutAttributesForElements(in: rect)
        }
//        var attributes = [UICollectionViewLayoutAttributes]()
        
        let arrAtributes = super.layoutAttributesForElements(in: rect)
        
        let visibleRect = CGRect(origin: (collectionView?.contentOffset)!, size: (collectionView?.bounds.size)!)
        let visibleCenterX = visibleRect.midX
        
        var newAttributesArray = Array<UICollectionViewLayoutAttributes>()
        
        for (index, attributes) in (arrAtributes?.enumerated())!{
            let newAttributes = attributes.copy() as! UICollectionViewLayoutAttributes
            newAttributesArray.append(newAttributes)
            
            let distanceFromCenter = visibleCenterX - newAttributes.center.x
            let absDistanceFromCenter = min(abs(distanceFromCenter), self.scalingOffset)
            let scale = absDistanceFromCenter * (self.minimumScaleFactor - 1) / self.scalingOffset + 1
            newAttributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        }
        
        
        return newAttributesArray
    }
}
