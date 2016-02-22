//
//  PublisherCollectionViewCell.swift
//  News
//
//  Created by Jorge Casariego on 22/2/16.
//  Copyright © 2016 Developer Inspirus. All rights reserved.
//

import UIKit

class PublisherCollectionViewCell: UICollectionViewCell
{

    @IBOutlet weak var publisherImageViewCell: UIImageView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var publisherTitleLabel: UILabel!
    
    var publisher: Publisher? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI()
    {
        publisherImageViewCell.image = publisher?.image
        publisherTitleLabel.text = publisher?.title
    }
}
