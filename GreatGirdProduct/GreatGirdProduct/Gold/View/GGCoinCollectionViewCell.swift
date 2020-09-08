//
//  GGCoinCollectionViewCell.swift
//  GreatGirdProduct
//
//  Created by 刘Sir on 2020/9/8.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class GGCoinCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var goldNumLabel: UILabel!
    @IBOutlet weak var moneyBtn: UIButton!
    var clickPayBlock: (() -> (Void))?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.borderColor = UIColor.qmui_color(withHexString: "#A3A3A3")?.cgColor
        contentView.layer.borderWidth = 2
        contentView.layer.cornerRadius = 23
        contentView.layer.masksToBounds = true
        moneyBtn.layer.cornerRadius = 6
        moneyBtn.layer.masksToBounds = true
    }
    @IBAction func clickMoneyBtn(_ sender: Any) {
        clickPayBlock?()

    }
    
}
