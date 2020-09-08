//
//  GGModeBGView.swift
//  GreatGirdProduct
//
//  Created by 刘Sir on 2020/9/8.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class GGModeBGView: UIView {
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
        label.text = "Stencil"
        label.textColor = UIColor.qmui_color(withHexString: "#282828")
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    var clickBlock: ((UIImage?)->(Void))?
    var clickDownHandler: (()->(Void))?

    let dataModel: GGModeModel = GGModeModel()
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
extension GGModeBGView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataModel.modeBGs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GGModeCollectionViewCellID", for: indexPath) as! GGModeCollectionViewCell
        if selIndex == indexPath.row {
            cell.contentImageView.image = dataModel.modeSelModels[indexPath.row]
            cell.selTipLabel.isHidden = false
        } else {
            cell.contentImageView.image = dataModel.modeModels[indexPath.row]
            cell.selTipLabel.isHidden = true
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selIndex = indexPath.row
        collectionView.reloadData()
        clickBlock?(dataModel.modeBGs[indexPath.row])
    }
}
