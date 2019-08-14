//
//  ViewController.swift
//  MusicSample
//
//  Created by 可部健二郎 on 2019/08/11.
//  Copyright © 2019 KenKenK. All rights reserved.
//

import UIKit
import StoreKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAuthorization()
    }
    
    func checkAuthorization(){
        switch SKCloudServiceController.authorizationStatus(){
        case .notDetermined:
            SKCloudServiceController.requestAuthorization { (status) in
                DispatchQueue.main.sync {
                    self.performSegue(withIdentifier: "toHome", sender: nil)
                }
            }
        case .authorized:
                self.performSegue(withIdentifier: "toHome", sender: nil)
        default:
            self.changeSetting()
        }
    }
    
    func changeSetting(){
        let alertController = UIAlertController(title: "AppleMusicへのアクセスを許可してください", message: "本アプリの設定画面より「メディアとAppleMusic」の項目をオンにしてください", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "設定画面へ", style: .default) { (action) in
            let url = URL(string: UIApplication.openSettingsURLString)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        let cancelButton = UIAlertAction(title: "キャンセル", style: .cancel) { (cancel) in
        }
        alertController.addAction(okButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true, completion: nil)
    }

}

