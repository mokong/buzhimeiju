//
//  MeiJuSearchResItem.swift
//  meijuplay
//
//  Created by Horizon on 23/12/2021.
//

import Foundation

struct MeiJuSearchResItem: Decodable {
    let list: [SearchSingleItem]?
    
    enum CodingKeys: String, CodingKey {
        case list
    }
}

struct SearchSingleItem: Decodable {
    var itemId: String? // 8636"
    var title: String? // 海军罪案调查处第十九季"
    var img: String? // https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2682455611.jpg
    
    enum CodingKeys: String, CodingKey {
        case itemId = "id"
        case title
        case img
    }
}
