//
//  GGBaseViewController.swift
//  GreatGirdProduct
//
//  Created by 刘Sir on 2020/9/8.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class GGBaseViewController: QMUICommonViewController {
    override func navigationBarBackgroundImage() -> UIImage? {
        UIImage.qmui_image(with: .white)
    }
    override func navigationBarStyle() -> UIBarStyle {
        .default
    }
    override func navigationBarBarTintColor() -> UIColor? {
        UIColor.qmui_color(withHexString: "#232323")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
    


}
