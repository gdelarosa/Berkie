//
//  NavigationBarExtension.swift
//  Berkie
//
//  Created by Gina De La Rosa on 9/11/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func navBarSetup() {
        
        navigationController?.navigationBar.barTintColor = UIColor.white
    
        // Centers image on navigation bar.
        let imageView = UIImageView(image: UIImage(named: "Loading_Landscape"))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        imageView.frame = titleView.bounds
        titleView.addSubview(imageView)
        self.navigationItem.titleView = titleView
    }
}
