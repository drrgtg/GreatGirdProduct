//
//  GGFilterCollectionViewCell.swift
//  GreatGirdProduct
//
//  Created by 刘Sir on 2020/9/8.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class GGFilterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentImageView.layer.cornerRadius = 6
    }

}
