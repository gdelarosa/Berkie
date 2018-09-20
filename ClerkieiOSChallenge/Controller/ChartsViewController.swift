//
//  ChartsViewController.swift
//  Berkie
//
//  Created by Gina De La Rosa on 9/10/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//  MARK: - This view controller will display five charts with subtle animations
//  Resource: https://www.appcoda.com/ios-charts-api-tutorial/

import UIKit
import Charts
import ViewAnimator
import PopupDialog

// MARK: - Charts Data Set
let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
let moneySavedOverMonths = [400.0, 340.0, 360.0, 500.0, 580.0, 600.0, 500.0, 720.0, 500.0, 600.0, 700.0, 800.0]

class ChartsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chartsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetups()
        chartsTableView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presentAnimation()
    }
    

    func navBarSetups() {
        navBarSetup()
        
        // Right Bar Button
        let graphsButton = UIBarButtonItem(image: UIImage(named: "information"), style: .plain, target: self, action: #selector(infoButtonAction))
        self.navigationItem.rightBarButtonItem  = graphsButton
        graphsButton.tintColor = UIColor.black

    }
    
    // MARK: - Presents Popup information
    @objc func infoButtonAction() {
        presentInfoPopup()
    }
    
    // MARK: - Animation
    
    func presentAnimation() {
        chartsTableView.alpha = 1
        let rotateAnimation = [AnimationType.rotate(angle: CGFloat.pi/6)]
        let cells = chartsTableView.visibleCells
        UIView.animate(views: cells, animations: rotateAnimation)
    }
    
    func presentInfoPopup() {
      
        let title = "Analytics Dashboard"
        let message = "These charts will display data related to your financial health. Overtime you will see how you've been able to save, how you spend, and how you budget."
        let gifURL : String = "https://media.giphy.com/media/3oKIPEqDGUULpEU0aQ/source.gif"
        let image = UIImage.gifImageWithURL(gifURL)
        let popup = PopupDialog(title: title, message: message, image: image)
    
        let buttonOne = CancelButton(title: "GREAT") {
            print("Closed popup.")
        }
   
        popup.addButtons([buttonOne])
        
        self.present(popup, animated: true, completion: nil)
    }
    
    // MARK: - TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "verticalCell", for: indexPath) as! VerticalTableViewCell
            cell.createChart()
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "horizontalCell", for: indexPath) as! HorizontalTableViewCell
            cell.createChart()
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "singleLineCell", for: indexPath) as! SingleLineTableViewCell
            cell.createChart()
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "duoLineCell", for: indexPath) as! DuoLineTableViewCell
            cell.createChart()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "pieCell", for: indexPath) as! PieTableViewCell
            cell.createChart()
            return cell
        }
    }
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}
