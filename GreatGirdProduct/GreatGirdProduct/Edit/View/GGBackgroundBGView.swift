//
//  GGBackgroundBGView.swift
//  GreatGirdProduct
//
//  Created by 刘Sir on 2020/9/8.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class GGBackgroundBGView: UIView {

    var selIndex: Int = 0

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 65, height: 80)
        layout.minimumLineSpacing = 18
        layout.minimumInteritemSpacing = 18
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 40, width: ScreenWidth, height: 80), collectionViewLayout: layout )
        collectionView.register(UINib(nibName: "GGModeCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "GGModeCollectionViewCellID")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return collectionView
    }()
    lazy var downBtn: QMUIButton = {
        let btn: QMUIButton = QMUIButton(type: .custom)
        btn.setImage(UIImage(named: "icon_down"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        btn.addTarget(self, action: #selector(clickDown), for: .touchUpInside)
        return btn
    }()
    lazy var titleLabel: QMUILabel = {
        let label: QMUILabel = QMUILabel(frame: CGRect.zero)
        label.text = "Background"
        label.textColor = UIColor.qmui_color(withHexString: "#282828")
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    var clickBlock: ((UIColor?)->(Void))?
    var clickDownHandler: (()->(Void))?

    let dataModel: GGBackgroundModel = GGBackgroundModel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(downBtn)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        self.addSubview(collectionView)
        
    }
    @objc func clickDown() {
        clickDownHandler?()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
extension GGBackgroundBGView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataModel.allColors.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GGModeCollectionViewCellID", for: indexPath) as! GGModeCollectionViewCell
        let index = indexPath.row - 1
        if index > -1 {
            cell.contentImageView.image = nil
            if selIndex == indexPath.row {
                cell.contentImageView.backgroundColor = dataModel.allColors[index]
                cell.selTipLabel.isHidden = false
            } else {
                cell.contentImageView.backgroundColor = dataModel.allColors[index]
                cell.selTipLabel.isHidden = true
            }
        } else {
            cell.contentImageView.image = UIImage(named: "icon_none")
            cell.contentImageView.backgroundColor = .clear
        }
        cell.contentImageView.layer.cornerRadius = 6
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selIndex = indexPath.row
        collectionView.reloadData()
        let index = indexPath.row - 1
        if index > -1 {
            clickBlock?(dataModel.allColors[index])
        } else {
            clickBlock?(.clear)
        }
    }
}
