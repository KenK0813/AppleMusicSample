//
//  MusicViewController.swift
//  MusicSample
//
//  Created by 可部健二郎 on 2019/08/11.
//  Copyright © 2019 KenKenK. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MediaPlayer
import StoreKit

class MusicViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var status = String()
    
    var songs:[Song]?
    var song:Song?
    let appleMusicAPI = AppleMusicAPI()
    
    @IBOutlet var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        setUserData(limit: 50)
    }
    
    func setUserData(limit:Int){
        appleMusicAPI.fetchUserToken {
            self.appleMusicAPI.fetchStorefronts {
                self.appleMusicAPI.getUserLibrary(limit: limit, completion: { (data) in
                    let group = DispatchGroup()
                    self.songs = [Song]()
                    for i in 0 ..< limit{
                        group.enter()
                        self.song = Song()
                        self.song?.title = data["data"][i]["attributes"]["name"].string
                        self.song?.artist = data["data"][i]["attributes"]["artistName"].string
                        self.songs?.append(self.song!)
                        group.leave()
                    }
                    group.notify(queue: .main){
                        self.tableView.reloadData()
                    }
                })
            }
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "musicCell")
        let song = songs![indexPath.row]
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artist
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs?.count ?? 0
    }
    
}

extension JSON{
    public var string:String?{
        get{
            switch self.type{
            case .string:
                return self.object as? String
            default:
                return nil
            }
        }
    }
}
