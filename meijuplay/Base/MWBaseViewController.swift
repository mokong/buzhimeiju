//
//  MWBaseViewController.swift
//  meijuplay
//
//  Created by MorganWang on 2021/11/28.
//

import UIKit

/// Controller 基类
class MWBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.white
        updateNavigationBarColor()
    }

    
    func updateNavigationBarColor() {
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }
        
        let type = ProjectConsts.shared.selectType
        if #available(iOS 13.0, *) {
            let barAppearance = UINavigationBarAppearance()
            barAppearance.backgroundColor = UIViewController.navBarColor(type)
            barAppearance.shadowColor = UIColor.clear
            barAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.MWCustomFont.titleFont
            ]
            navigationBar.scrollEdgeAppearance = barAppearance
            navigationBar.standardAppearance = barAppearance
            navigationBar.shadowImage = UIImage()
        } else {
            // Fallback on earlier versions
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().barTintColor = UIViewController.navBarColor(type)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
