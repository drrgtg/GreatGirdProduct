//
//  AppDelegate.swift
//  GreatGirdProduct
//
//  Created by 刘Sir on 2020/9/8.
//  Copyright © 2020 tutu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupDefaultData()
        setupRootVC()
        return true
    }
    func setupRootVC(){
        let wind = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "GGViewControllerID")
        window = wind
        wind.rootViewController = GGBaseNavigationController(rootViewController: vc)
        wind.makeKeyAndVisible()
    }
    func setupDefaultData() {
        if UserDefaults.standard.string(forKey: kIAPDefaultGoldNumber) == nil {
            UserDefaults.standard.setValue("3000", forKey: kIAPDefaultGoldNumber)
        }
    }
}

