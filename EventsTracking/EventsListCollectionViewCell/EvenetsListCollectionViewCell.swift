//
//  EvenetsListCollectionViewCell.swift
//  EventsTracking
//
//  Created by Nikhil Raj K on 12/11/16.
//  Copyright © 2016 Nikhil Raj K. All rights reserved.
//

import UIKit

class EvenetsListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var EventNameLabel: UILabel!
    
    @IBOutlet weak var eventPlaceLabel: UILabel!
    
    @IBOutlet weak var eventEntryLabel: UILabel!
    
    @IBOutlet weak var eventListImgView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
