//
//  GGFeedbackViewController.swift
//  GreatGirdProduct
//
//  Created by 刘Sir on 2020/9/8.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

class GGFeedbackViewController: GGBaseViewController {

    @IBOutlet weak var textView: QMUITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Feedback"
    }

    @IBAction func clickSubmit(_ sender: Any) {
        guard textView.text.count > 0 else {
            JPToast.showToast("Feedback content cannot be empty")
            return
        }
        JPToast.showLoading("Please waiting")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            JPToast.hidLoading()
            JPToast.showSuccess("The feedback is successful, we have received your feedback, thank you")
            self.textView.text = ""
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
