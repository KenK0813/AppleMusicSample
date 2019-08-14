//
//  AppleMusicAPI.swift
//  MusicSample
//
//  Created by 可部健二郎 on 2019/08/12.
//  Copyright © 2019 KenKenK. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import StoreKit

class AppleMusicAPI{
    private let developerToken = "****"
    var userToken:String?
    var storefrontId:String?
    
    func fetchUserToken(completion:@escaping (() -> Void)){
        let serviceController = SKCloudServiceController()
        serviceController.requestUserToken(forDeveloperToken: developerToken) { (userToken, err) in
            guard err == nil else {return}
            if let userToken = userToken{
                self.userToken = userToken
            }
            completion()
        }
    }
    
    func fetchStorefronts(compeltion:@escaping () -> Void){
        let AuthHeader : [String:String] = ["Authorization":"Bearer\(developerToken)","Music-User-Token":userToken!]
        Alamofire.request("https://api.music.apple.com/v1/me/storefront", method: .get, encoding: URLEncoding.default, headers: AuthHeader).responseJSON { (response) in
            guard let response = response.result.value else {return}
            let data = JSON(response)
            if let storefrontId = data["data"][0]["id"].string{
                self.storefrontId = storefrontId
            }
            compeltion()
        }
    }
    
    func getUserLibrary(limit:Int,completion:@escaping (JSON) -> Void){
        let AuthHeader : [String:String] = ["Authorization":"Bearer\(developerToken)","Music-User-Token":userToken!]
        let parameters : Parameters = ["limit":limit]
        Alamofire.request("https://api.music.apple.com/v1/me/library/songs", method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers:AuthHeader).responseJSON {responseData in
            guard let response = responseData.result.value else {return}
            let data = JSON(response)
            completion(data)
        }
    }
    
}
