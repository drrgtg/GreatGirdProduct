//
//  GGFilterBGView.swift
//  GreatGirdProduct
//
//  Created by 刘Sir on 2020/9/8.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class GGFilterBGView: UIView {

    
    var filterImages: [UIImage] = []
    var selIndex: Int = 0

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 65, height: 90)
        layout.minimumLineSpacing = 18
        layout.minimumInteritemSpacing = 18
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 40, width: ScreenWidth, height: 100), collectionViewLayout: layout )
        collectionView.register(UINib(nibName: "GGFilterCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "GGFilterCollectionViewCellID")
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
        label.text = "Filter"
        label.textColor = UIColor.qmui_color(withHexString: "#282828")
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    var clickBlock: ((UIImage?)->(Void))?
    var clickDownHandler: (()->(Void))?
    let dataModel: GGFilterModel = GGFilterModel()
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
    
    func fillImage(_ image: UIImage) {
        filterImages.append(image)
        filterImage(image)
    }
    func filterImage(_ image: UIImage) {
        JPToast.showLoading("Please waiting")
        DispatchQueue.global().async {
            for i in 1..<self.dataModel.filterNames.count {
                let filterName = self.dataModel.filterNames[i]
                guard let ciImage = CIImage(image: image),let filter = CIFilter(name: filterName, parameters: [kCIInputImageKey: ciImage]) else {
                    JPToast.hidLoading()
                    JPToast.showToast("An error occurred, please try again~")
                    return
                }
                let context = CIContext()
                if let outputImage = filter.outputImage , let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                    let oImage = UIImage(cgImage: cgImage)
                    self.filterImages.append(oImage)
                }
            }
            DispatchQueue.main.async {
                JPToast.hidLoading()
                self.collectionView.reloadData()
            }
        }
    }
}
extension GGFilterBGView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filterImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GGFilterCollectionViewCellID", for: indexPath) as! GGFilterCollectionViewCell
        let image = filterImages[indexPath.row]
        cell.nameLabel.text = dataModel.filterSName[indexPath.row]
        cell.contentImageView.image = image
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selIndex = indexPath.row
        collectionView.reloadData()
        let index = indexPath.row
        clickBlock?(filterImages[index])
    }
}
