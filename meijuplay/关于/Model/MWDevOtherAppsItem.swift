//
//  MWDevOtherAppsItem.swift
//  meijuplay
//
//  Created by Horizon on 25/2/2022.
//

import Foundation

enum MWDevAppType: String {
    case watermarkCamera = "水印相机"
    case game24 = "挑战24点"
    case meijuplay = "不止美剧"
    
    func getAppImageName() -> String {
        switch self {
        case .watermarkCamera:
            return "icon_watermarkcamera"
        case .game24:
            return "icon_game24"
        case .meijuplay:
            return "icon_meijuplay"
        }
    }
    
    func getAppId() -> String {
        switch self {
        case .watermarkCamera:
            return "1607957232"
        case .game24:
            return "1610914130"
        case .meijuplay:
            return "1611529480"
        }
    }
}
