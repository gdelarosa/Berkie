//
//  HomeViewController.swift
//  ClerkieiOSChallenge
//
//  Created by Gina De La Rosa on 9/9/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//  MARK: - This is the home view controller after the user logs in. Will be able to chat here.

import UIKit

class HomeViewController: UIViewController {
    
//    override func viewDidAppear(_ animated: Bool) {
//
//
//
//        let customButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
//        customButton.setImage(UIImage.init(named:"Chart-6.png"), for: .normal)
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: customButton)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let customButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
        customButton.setImage(UIImage.init(named:"Chart-6.png"), for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: customButton)
     
    }
    
    @objc func goToCharts() {
        
    }


}
