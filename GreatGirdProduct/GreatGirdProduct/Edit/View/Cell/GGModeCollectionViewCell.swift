//
//  GGModeCollectionViewCell.swift
//  GreatGirdProduct
//
//  Created by 刘Sir on 2020/9/8.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class GGModeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var selTipLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selTipLabel.isHidden = true
        selTipLabel.layer.cornerRadius = 1
    }
    

}
