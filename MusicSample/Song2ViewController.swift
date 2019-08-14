//
//  Song2ViewController.swift
//  MusicSample
//
//  Created by 可部健二郎 on 2019/08/11.
//  Copyright © 2019 KenKenK. All rights reserved.
//

import UIKit
import MediaPlayer

class Song2ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var mediaItems = [Song]()
    var mediaItem:Song?
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        query()
    }
    
    func query(){
        let group = DispatchGroup()
        self.mediaItems = [Song]()
        for item in MPMediaQuery.songs().items!{
            group.enter()
            self.mediaItem = Song()
            if let title = item["title"] as? String,let artist = item["artist"] as? String{
                self.mediaItem?.title = title
                self.mediaItem?.artist = artist
            }
            self.mediaItems.append(self.mediaItem!)
            group.leave()
        }
        group.notify(queue: .main){
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "song2Cell", for: indexPath)
        cell.textLabel?.text = mediaItems[indexPath.row].title
        cell.detailTextLabel?.text = mediaItems[indexPath.row].artist
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = MPMusicPlayerController.systemMusicPlayer
        let query = MPMediaQuery.songs()
        player.nowPlayingItem = query.items![indexPath.row]
        player.play()
    }

}
