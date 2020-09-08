//
//  GGGoldViewController.swift
//  GreatGirdProduct
//
//  Created by 刘Sir on 2020/9/8.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit
import IAPurchaseManager

class GGProductItem: NSObject {
    var price: String = ""
    var goldNumber: String = ""
    var iapID: String = ""
    var desc: String = ""
    init(_ price: String, goldNumber: String, iapID: String, desc: String) {
        super.init()
        self.price = price
        self.goldNumber = goldNumber
        self.iapID = iapID
        self.desc = desc
    }
}
class GGGoldViewController: GGBaseViewController {
    private var coinBtn: QMUIButton?

    private let dataSource: Array = [
        GGProductItem("$6.99", goldNumber: "1000", iapID: "com.tutu.GreatGirdProduct.buy258", desc: "X 1000"),
        GGProductItem("$11.99", goldNumber: "2000", iapID: "com.tutu.GreatGirdProduct.buy388", desc: "X 2000"),
        GGProductItem("$19.99", goldNumber: "3000", iapID: "com.tutu.GreatGirdProduct.buy518", desc: "X 3000"),
        GGProductItem("$29.99", goldNumber: "4000", iapID: "com.tutu.GreatGirdProduct.buy648", desc: "X 4000"),
        GGProductItem("$49.99", goldNumber: "5000", iapID: "com.tutu.GreatGirdProduct.buy848", desc: "X 5000"),
        GGProductItem("$99.99", goldNumber: "6000", iapID: "com.tutu.GreatGirdProduct.buy998", desc: "X 6000"),
        GGProductItem("$59.99", goldNumber: "7000", iapID: "com.tutu.GreatGirdProduct.buy1298", desc: "X 7000"),
        GGProductItem("$69.99", goldNumber: "8000", iapID: "com.tutu.GreatGirdProduct.buy1998", desc: "X 8000"),
        GGProductItem("$79.99", goldNumber: "9000", iapID: "com.tutu.GreatGirdProduct.buy3998", desc: "X 9000"),
        GGProductItem("$89.99", goldNumber: "10000", iapID: "com.tutu.GreatGirdProduct.buy4998", desc: "X 10000")
    ]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = (ScreenWidth - 45) / 2
        let height = width * 190 / 167
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "GGCoinCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "GGCoinCollectionViewCellID")
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "Coins"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let goldNumber = UserDefaults.standard.string(forKey: kIAPDefaultGoldNumber) {
            coinBtn?.setTitle(goldNumber, for: .normal)
            coinBtn?.sizeToFit()
        }
    }
    override func initSubviews() {
        super.initSubviews()
        // rightBar
        let rightBtn = QMUIButton(type: .custom)
        rightBtn.setImage(UIImage(named: "icon_home_gold"), for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        rightBtn.setTitle("", for: .normal)
        rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        rightBtn.setTitleColor(UIColor.qmui_color(withHexString: "#191919"), for: .normal)
        rightBtn.spacingBetweenImageAndTitle = 6
        rightBtn.sizeToFit()
        coinBtn = rightBtn
        
        view.addSubview(collectionView)
    }
    
    // Param MARK: private method
    private func payAtIndex(_ row: Int) {
        let product = dataSource[row]
        IAPManager.shared.purchaseProductWithId(productId: product.iapID) {[weak self] (error) -> Void in
            if error == nil, let sself = self {
              // successful purchase!
                if let goldNumber = UserDefaults.standard.string(forKey: kIAPDefaultGoldNumber) {
                    let total = Int(goldNumber)! + Int(product.goldNumber)!
                    UserDefaults.standard.setValue("\(total)", forKey: kIAPDefaultGoldNumber)
                    sself.coinBtn?.setTitle("\(total)", for: .normal)
                    sself.coinBtn?.sizeToFit()
                }
            } else {
              // something wrong..
                JPToast.showToast(error?.localizedDescription ?? "")
            }
        }
    }
}

extension GGGoldViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GGCoinCollectionViewCellID", for: indexPath) as! GGCoinCollectionViewCell
        let product = dataSource[indexPath.row]
        cell.goldNumLabel.text = product.desc
        cell.moneyBtn.setTitle(product.price, for: .normal)
        cell.clickPayBlock = {[weak self] in
            self?.payAtIndex(indexPath.row)
        }
        return cell
    }
}
