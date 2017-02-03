//
//  OverlayViewCell.swift
//  CustomCamera
//
//  Created by Waris on 19/01/2011.
//  Copyright © 2016 WarisSaqi. All rights reserved.

import UIKit


class OverlayViewCell: UICollectionViewCell {
        
    @IBOutlet weak var gradientView: UIImageView!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("OverlayViewCell-> awakeFromNib()")
        self.alpha = 1.0;
    }
    
}
