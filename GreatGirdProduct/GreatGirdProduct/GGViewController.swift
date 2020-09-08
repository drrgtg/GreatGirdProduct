//
//  GGBaseViewController.swift
//  GreatGirdProduct
//
//  Created by 刘Sir on 2020/9/8.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit
import TZImagePickerController
import CWLateralSlide

class GGViewController: GGBaseViewController {
    
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var goldBtn: UIButton!
    override func navigationBarBackgroundImage() -> UIImage? {
        UIImage.qmui_image(with: .clear)
    }
    override func navigationBarStyle() -> UIBarStyle {
        .blackOpaque
    }
    override func navigationBarBarTintColor() -> UIColor? {
        .clear
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor =  UIColor.qmui_color(withHexString: "#F9F9F9")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let goldNumber = UserDefaults.standard.string(forKey: kIAPDefaultGoldNumber) {
            goldBtn?.setTitle(goldNumber, for: .normal)
        }
    }
    override func initSubviews() {
        super.initSubviews()
        // left
        let leftBtn = QMUIButton(type: .custom)
        leftBtn.setImage(UIImage(named: "icon_setting"), for: .normal)
        leftBtn.addTarget(self, action: #selector(clickSetting), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        // right
        let button = QMUIButton(type: .custom)
        button.setImage(UIImage(named: "icon_home_gold"), for: .normal)
        button.setTitleColor(UIColor.qmui_color(withHexString: "#1f1f1f"), for: .normal)
        goldBtn = button
        button.backgroundColor = .white
        button.contentEdgeInsets = UIEdgeInsets(top: 7, left: 14, bottom: 7, right: 14)
        button.spacingBetweenImageAndTitle = 6
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        button.addTarget(self, action: #selector(clickGold), for: .touchUpInside)

    }
    @IBAction func clickPic(_ sender: Any) {
        
        guard let imagePickerVC = TZImagePickerController(maxImagesCount: 1, delegate: self) else {
            return
        }
        imagePickerVC.didFinishPickingPhotosHandle = {[weak self] (photos, assets, isSelectOriginalPhoto) in
            // go to edit
            guard let image = photos?.first else {
                return
            }
            let vc = GGEditViewController()
            vc.image = image
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        present(imagePickerVC, animated: true, completion: nil)
    }
    @objc func clickSetting() {
        cw_showDefaultDrawerViewController(GGSettingViewController())
    }
    @objc func clickGold() {
        let vc = GGGoldViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension GGViewController: TZImagePickerControllerDelegate {
    
}
