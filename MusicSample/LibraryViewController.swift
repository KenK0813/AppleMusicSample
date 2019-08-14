//
//  LibraryViewController.swift
//  MusicSample
//
//  Created by 可部健二郎 on 2019/08/11.
//  Copyright © 2019 KenKenK. All rights reserved.
//

import UIKit
import StoreKit
import MediaPlayer

class LibraryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    let array = ["アーティスト","アルバム","曲"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "libraryCell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Music") as? MusicViewController
            vc!.status = "アーティスト"
            performSegue(withIdentifier: "toMusic", sender: nil)
        case 1:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Music") as? MusicViewController
            vc!.status = "アルバム"
            performSegue(withIdentifier: "toMusic", sender: nil)
        default:
            performSegue(withIdentifier: "toSong2", sender: nil)
        }
    }

}
