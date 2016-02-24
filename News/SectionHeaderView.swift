//
//  SectionHeaderView.swift
//  News
//
//  Created by Jorge Casariego on 23/2/16.
//  Copyright © 2016 Developer Inspirus. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    var titleLabel: UILabel?
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupSubviews()
        self.autolayoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupSubviews()
        self.autolayoutSubviews()
    }
    
    func setupSubviews(){
        self.titleLabel = UILabel()
        self.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel?.font = UIFont.systemFontOfSize(24.0)
        self.titleLabel?.textColor = UIColor.whiteColor()
        self.addSubview(self.titleLabel!)
    }
    
    func autolayoutSubviews(){
        self.titleLabel!.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 10).active = true
        self.titleLabel!.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor, constant: -10).active = true
        self.titleLabel!.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor, constant: 10).active = true
        self.titleLabel!.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor, constant: 10).active = true
    }
    
    

}
