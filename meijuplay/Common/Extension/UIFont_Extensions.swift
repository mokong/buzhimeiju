//
//  UIFont_Extensions.swift
//  meijuplay
//
//  Created by Horizon on 8/12/2021.
//

import Foundation
import UIKit

public extension UIFont {
    static let custom = MWCustomFont.self
    
    enum MWCustomFont {
        public static let titleFont: UIFont = UIFont.pingFangMedium(21.0)
        public static let headerFont: UIFont = UIFont.pingFangMedium(18.0)
        public static let normalFont: UIFont = UIFont.pingFangRegular(16.0)
        public static let descFont: UIFont = UIFont.pingFangRegular(14.0)
        public static let footerFont: UIFont = UIFont.pingFangRegular(12.0)
    }
    
    enum PingFangFontType: String {
        case thin = "PingFangSC-Thin"
        case regular = "PingFangSC-Regular"
        case bold = "PingFangSC-Semibold"
        case light = "PingFangSC-Light"
        case medium = "PingFangSC-Medium"
        case numberBold = "DINAlternate-Bold"
    }
    
    static func mwFont(type: PingFangFontType, size : CGFloat, scale : CGFloat = 1) -> UIFont {
        return UIFont(name: type.rawValue, size: size * scale) ?? UIFont.systemFont(ofSize: size * scale)
    }
    
    static func pingFangRegular(_ size: CGFloat) -> UIFont {
        return UIFont.mwFont(type: .regular, size: size)
    }
    
    static func pingFangMedium(_ size: CGFloat) -> UIFont {
        return UIFont.mwFont(type: .medium, size: size)
    }
    
    static func pingFangBold(_ size: CGFloat) -> UIFont {
        return UIFont.mwFont(type: .bold, size: size)
    }
    
    static func pingFangLight(_ size: CGFloat) -> UIFont {
        return UIFont.mwFont(type: .light, size: size)
    }
}

private extension UIFont.MWCustomFont {
    func scaled(baseFont: UIFont, forTextStyle textStyle: UIFont.TextStyle = .body, maximumFactor: CGFloat? = nil) -> UIFont {
        if #available(iOS 11.0, *) {
            let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
            if let maximumFactor = maximumFactor {
                let maximumPointSize = baseFont.pointSize * maximumFactor
                return fontMetrics.scaledFont(for: baseFont, maximumPointSize: maximumPointSize)
            }
            return fontMetrics.scaledFont(for: baseFont)
        } else {
            // Fallback on earlier versions
            return baseFont
        }
    }
}

