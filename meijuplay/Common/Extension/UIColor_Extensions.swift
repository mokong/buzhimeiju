//
//  UIColor_Extensions.swift
//  meijuplay
//
//  Created by Horizon on 8/12/2021.
//

import Foundation
import UIKit

extension UIColor {
    static let custom = MWCustomColor.self
    
    static private func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor {
                $0.userInterfaceStyle == .dark ? dark : light
            }
        } else {
            return light
        }
    }
    
    enum MWCustomColor {
        public static let primary: UIColor = dynamicColor(light: UIColor(hex: 0x367EF5), dark: UIColor(hex: 0x367EF5))
        public static let background: UIColor = dynamicColor(light: .white, dark: .white)
        public static let lightBackground: UIColor = dynamicColor(light: UIColor(hex: 0xF8FBFF), dark: UIColor(hex: 0xF8FBFF))
        public static let buttonBackground: UIColor = dynamicColor(light: UIColor(hex: 0xF0F2F4), dark: UIColor(hex: 0xF0F2F4))
        public static let dimBack: UIColor = dynamicColor(light: UIColor(hex: 0x1C1C1C), dark: UIColor(hex: 0x1C1C1C))
        public static let lightDimBack: UIColor = dynamicColor(light: UIColor(hex: 0x272727), dark: UIColor(hex: 0x272727))

        public static let line: UIColor = dynamicColor(light: UIColor(hex: 0xF2F2F2), dark: UIColor(hex: 0xF2F2F2))
        public static let borderLine: UIColor = dynamicColor(light: UIColor(hex: 0xC1C1C1), dark: UIColor(hex: 0xC1C1C1))

        public static let hightlightText: UIColor = dynamicColor(light: UIColor(hex: 0x2E7CF6), dark: UIColor(hex: 0x2E7CF6))
        public static let primaryText: UIColor = dynamicColor(light: UIColor(hex: 0x333333), dark: UIColor(hex: 0x333333))
        public static let secondaryText: UIColor = dynamicColor(light: UIColor(hex: 0x818181), dark: UIColor(hex: 0x818181))
        public static let whiteText: UIColor = dynamicColor(light: .white, dark: .white)

        public static let primaryButton: UIColor = dynamicColor(light: UIColor(hex: 0x367EF5), dark: UIColor(hex: 0x367EF5))
        public static let secondaryButton: UIColor = dynamicColor(light: UIColor(hex: 0x878787), dark: UIColor(hex: 0x878787))
        public static let normalButton: UIColor = dynamicColor(light: UIColor(hex: 0x272727), dark: UIColor(hex: 0x272727))
        public static let selectedButton: UIColor = dynamicColor(light: UIColor(hex: 0x2E7CF6), dark: UIColor(hex: 0x2E7CF6))


        public static let navigationBar1: UIColor = dynamicColor(light: UIColor(hex: 0x2E7CF6), dark: UIColor(hex: 0x2E7CF6)) // meiju, 天蓝色
        public static let navigationBar2: UIColor = dynamicColor(light: UIColor(hex: 0xF2835A), dark: UIColor(hex: 0xF2835A)) // hanju, 粉红色
        public static let navigationBar3: UIColor = dynamicColor(light: UIColor(hex: 0x57A8D7), dark: UIColor(hex: 0x57A8D7)) // riju, 小清新
        public static let navigationBar4: UIColor = dynamicColor(light: UIColor(hex: 0x40444E), dark: UIColor(hex: 0x40444E)) // taiju,

    }
}

public extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255.0,
            G: CGFloat((hex >> 08) & 0xff) / 255.0,
            B: CGFloat((hex >> 00) & 0xff) / 255.0
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }
}
