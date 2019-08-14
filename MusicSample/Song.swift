//
//  File.swift
//  MusicSample
//
//  Created by 可部健二郎 on 2019/08/11.
//  Copyright © 2019 KenKenK. All rights reserved.
//

import Foundation

struct Song: Codable {
    var title:String?
    var artist:String?
    var playbackStoreID:String?
    var isStreamable:Bool?
    
}
