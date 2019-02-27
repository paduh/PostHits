//
//  BaseViewController.swift
//  Assignment
//
//  Created by Perfect Aduh on 27/02/2019.
//  Copyright © 2019 PAK Consulting. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(statusManager), name: .flagsChanged, object: Network.reachability)
    }
    
    func updateUserInterface() {
        guard let status = Network.reachability?.status else { return }
        
        if status == .unreachable {
            showAlert(message: "You are offline.")
        }
    }
    
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }


}
