//
//  MeiJuAboutItem.swift
//  meijuplay
//
//  Created by Horizon on 24/12/2021.
//

import Foundation

enum MeiJuAboutType {
    case comment
    case share
    case policy
    case devOtherApps
}

class MeiJuAboutItem {
    var title: String?
    var type: MeiJuAboutType = .comment
}
