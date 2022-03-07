//
//  String_Extensions.swift
//  meijuplay
//
//  Created by Horizon on 24/12/2021.
//

import Foundation
import UIKit

extension String {
    // 根据宽度和字体，计算高度
    func getStrHeight(width: CGFloat, font: UIFont) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
                                                       options: .usesLineFragmentOrigin,
                                                       attributes: [NSAttributedString.Key.font : font],
                                                       context: nil)
        let resultH = ceil(rect.height) + 0.1
        return resultH
    }
    
    // 根据高度和字体，计算宽度
    func getStrWidth(height: CGFloat, font: UIFont) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height),
                                                       options: .usesLineFragmentOrigin,
                                                       attributes: [NSAttributedString.Key.font : font],
                                                       context: nil)
        let resultW = ceil(rect.width) + 0.1
        return resultW
    }
    
}
