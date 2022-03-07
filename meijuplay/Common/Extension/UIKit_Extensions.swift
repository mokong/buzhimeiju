//
//  UIKit_Extensions.swift
//  meijuplay
//
//  Created by Horizon on 8/12/2021.
//

import Foundation
import UIKit

extension UIView {
    /// Remove all subviews
    func removeAllSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
}

extension UIDevice {
    /// 不准确的导航栏高度
    static func navigationBarH() -> CGFloat {
        if isFullScreen() {
            return 88.0
        }
        else {
            return 64.0
        }
    }
    
    /// 是否是全面屏
    static func isFullScreen() -> Bool {
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.delegate?.window,
                let height = window?.safeAreaInsets.bottom,
                height > 0 {
                return true
            }
            else {
                return false
            }
        } else {
            // Fallback on earlier versions
            return false
        }
    }
    
    /// 状态栏高度
    static func statusBarH() -> CGFloat {
        var height: CGFloat = 0.0
        if #available(iOS 13.0, *) {
            height = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            height = UIApplication.shared.statusBarFrame.height
        }
        return height
    }
}
