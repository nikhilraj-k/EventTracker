//
//  GridCollectionViewLayout.swift
//  EventsTracking
//
//  Created by Nikhil Raj K on 12/11/16.
//  Copyright © 2016 Nikhil Raj K. All rights reserved.
//

import UIKit

class GridCollectionViewLayout: UICollectionViewFlowLayout {
    
    let itemHeight: CGFloat = 320
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    
    func setupLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .Vertical
    }
    
    /// here we define the width of each cell, creating a 2 column layout. In case you would create 3 columns, change the number 2 to 3
    func itemWidth() -> CGFloat {
        return (CGRectGetWidth(collectionView!.frame)/3)-1
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSizeMake(itemWidth(), itemHeight)
        }
        get {
            return CGSizeMake(itemWidth(), itemHeight)
        }
    }
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint) -> CGPoint {
      
        return collectionView!.contentOffset
    }

    
    

}
