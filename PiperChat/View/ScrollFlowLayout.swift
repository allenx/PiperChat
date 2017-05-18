//
//  ScrollFlowLayout.swift
//  PiperChat
//
//  Created by Allen X on 5/18/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import UIKit

class ScrollFlowLayout: UICollectionViewFlowLayout {
    
    var dynamicAnimator: UIDynamicAnimator?
    
    override func prepare() {
        super.prepare()
        
        if dynamicAnimator == nil {
            dynamicAnimator = UIDynamicAnimator.init(collectionViewLayout: self)
            
            let contentSize = self.collectionViewContentSize
            let itemArray = super.layoutAttributesForElements(in: CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height))
            
            for attri in itemArray! {
                let spring = UIAttachmentBehavior.init(item: attri, attachedToAnchor: attri.center)
                spring.length = 0
                spring.damping = 0.5
                spring.frequency = 0.8
                self.dynamicAnimator!.addBehavior(spring)
            }
            
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.dynamicAnimator?.items(in: rect) as! [UICollectionViewLayoutAttributes]?
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.dynamicAnimator?.layoutAttributesForCell(at: indexPath)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let scrollView = self.collectionView! as? UIScrollView
        let delta = newBounds.origin.y - (scrollView!.bounds.origin.y)
        let touchLocation = scrollView?.panGestureRecognizer.location(in: scrollView)
        for behavior  in (self.dynamicAnimator?.behaviors)! {
            if let attach = behavior as? UIAttachmentBehavior{
                let anchorPoint = attach.anchorPoint
                let distanceFromTouch = fabs((touchLocation?.y)! - anchorPoint.y)
                let scrollResistance = distanceFromTouch / 500.0
                
                let attri = attach.items.first as? UICollectionViewLayoutAttributes
                var center = attri!.center
                center.y += min(delta * scrollResistance, delta)
                attri!.center = center
                
                self.dynamicAnimator!.updateItem(usingCurrentState: attri!)
                
            }
        }
        
        
        return false
    }
}

