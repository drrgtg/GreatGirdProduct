//
//  GGSettingViewController.swift
//  GreatGirdProduct
//
//  Created by 刘Sir on 2020/9/8.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit
import SnapKit

class GGSettingViewController: GGBaseViewController {
    private var cacheSize = "\(arc4random()%10).0M"

    lazy var tableView: QMUITableView = {
        let tableView = QMUITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(UINib(nibName: "GGSettingTableViewCell", bundle: .main), forCellReuseIdentifier: "GGSettingTableViewCellID")
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    override func initSubviews() {
        super.initSubviews()
        let titleLabel = UILabel()
        titleLabel.text = "Setting"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = UIColor.qmui_color(withHexString: "#1C1E1C")
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(view).multipliedBy(0.75)
            make.top.equalTo(view.snp.top).offset(40)
            make.height.equalTo(64)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.leading.bottom.equalToSuperview()
            make.width.equalTo(view).multipliedBy(0.75)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
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
extension GGSettingViewController: QMUITableViewDelegate, QMUITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GGSettingTableViewCellID", for: indexPath) as! GGSettingTableViewCell
        switch indexPath.row {
        case 0:
            cell.leftLabel.text = "Version"
            cell.rightLabel.text = PFCFBundleVersion()
            cell.accessoryType = .none
        case 1:
            cell.leftLabel.text = "Clear Cache"
            cell.rightLabel.text = cacheSize
            cell.accessoryType = .none
        case 2:
            cell.leftLabel.text = "Privacy Policy"
            cell.rightLabel.text = ""
            cell.accessoryType = .disclosureIndicator
        case 3:
            cell.leftLabel.text = "Terms of Service"
            cell.rightLabel.text = ""
            cell.accessoryType = .disclosureIndicator
        default:
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            print("current Version")
        case 1:
            JPToast.showSuccess("clear successed")
            cacheSize = "0M"
            tableView.reloadData()
        case 2:
            let vc = GGPrivacyViewController()
            cw_push(vc)
        case 3:
            let vc = GGTermServiceViewController()
            cw_push(vc)
        default:
            break
        }
    }
}
