//
//  Storefront.swift
//  MusicSample
//
//  Created by 可部健二郎 on 2019/08/12.
//  Copyright © 2019 KenKenK. All rights reserved.
//

import Foundation

struct Storefronts:Decodable {
    let data: [Storefront]
}

struct Storefront:Decodable {
    let id: String
    let type: String
    let href: String
    let attributes: Attributes
    
    struct Attributes: Decodable {
        let defaultLanguageTag: String
        let name: String
        let supportedLanguageTags: [String]
    }
}
