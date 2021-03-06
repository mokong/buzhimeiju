//
//  EZPlayerThumbnail.swift
//  EZPlayer
//
//  Created by yangjun zhu on 2016/12/28.
//  Copyright © 2016年 yangjun zhu. All rights reserved.
//

import AVFoundation

/// 返回的截图对象
public struct EZPlayerThumbnail {
    public var requestedTime: CMTime
    public var image: UIImage?
    public var actualTime: CMTime
    public var result: AVAssetImageGenerator.Result
    public var error: Error?
}
