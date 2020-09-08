//
//  GGEditViewController.swift
//  GreatGirdProduct
//
//  Created by 刘Sir on 2020/9/8.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class GGEditViewController: GGBaseViewController {

    var image: UIImage?
    let bgImageView = UIImageView()
    let contentImageView = UIImageView()
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var toolsView: UIView!
    @IBOutlet weak var btn1: QMUIButton!
    @IBOutlet weak var btn2: QMUIButton!
    @IBOutlet weak var btn3: QMUIButton!
    @IBOutlet weak var btn4: QMUIButton!
    @IBOutlet weak var btn5: QMUIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Edit"
        view.backgroundColor = UIColor.qmui_color(withHexString: "#F9F9F9")
    }
    override func initSubviews() {
        super.initSubviews()
        
        btn1.imagePosition = .top
        btn2.imagePosition = .top
        btn3.imagePosition = .top
        btn4.imagePosition = .top
        btn5.imagePosition = .top
        btn1.spacingBetweenImageAndTitle = 10
        btn2.spacingBetweenImageAndTitle = 10
        btn3.spacingBetweenImageAndTitle = 10
        btn4.spacingBetweenImageAndTitle = 10
        btn5.spacingBetweenImageAndTitle = 10
        imageContainerView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        imageContainerView.contentMode = .scaleAspectFill
        imageContainerView.addSubview(contentImageView)
        contentImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
        }
        contentImageView.contentMode = .scaleAspectFill
        contentImageView.layer.masksToBounds = true
        contentImageView.image = image
        // 1 Mode
        
        // 2 Background
        
        // 3 Sticker
        
        // 4 Filter
        
    }
    @IBAction func clickBtn1(_ sender: Any) {
        
    }
    @IBAction func clickBtn2(_ sender: Any) {
        
    }
    @IBAction func clickBtn3(_ sender: Any) {
        
    }
    @IBAction func clickBtn4(_ sender: Any) {
        
    }
    @IBAction func clickBtn5(_ sender: Any) {
        
    }
}
