//
//  GGSaveViewController.swift
//  GreatGirdProduct
//
//  Created by 刘Sir on 2020/9/9.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class GGSaveViewController: GGBaseViewController {
    var image: UIImage?

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Share"
        imageView.image = image
    }

    override func initSubviews() {
        super.initSubviews()
        // right
        let rightBtn = QMUIButton(type: .custom)
        rightBtn.setImage(UIImage(named: "icon_home"), for: .normal)
        rightBtn.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
        rightBtn.addTarget(self, action: #selector(goHome), for: .touchUpInside)
    }
    @IBAction func clickSave(_ sender: Any) {
        guard let sImage = image else {
            return
        }
        let activityItems = NSMutableArray(array: [sImage])
        let activityController = UIActivityViewController(activityItems: activityItems as! [Any], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    @objc func goHome() {
        navigationController?.popToRootViewController(animated: true)
    }

}
