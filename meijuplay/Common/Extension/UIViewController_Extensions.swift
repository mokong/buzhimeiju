//
//  UIViewController_Extensions.swift
//  meijuplay
//
//  Created by Horizon on 22/12/2021.
//

import Foundation
import UIKit

extension UIViewController {
    var topBarHeight: CGFloat {
        var top = self.navigationController?.navigationBar.frame.height ?? 0.0
        top += UIDevice.statusBarH()
        return top
    }
    
    
    static func navBarColor(_ type: EpisodeType) -> UIColor {
        switch type {
        case .MeiJu:
            return UIColor.MWCustomColor.navigationBar1
        case .HanJu:
            return UIColor.MWCustomColor.navigationBar2
        case .RiJu:
            return UIColor.MWCustomColor.navigationBar3
        case .TaiJu:
            return UIColor.MWCustomColor.navigationBar4
        default:
            return UIColor.MWCustomColor.navigationBar1
        }
    }

}
