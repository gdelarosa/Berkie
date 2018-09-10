//
//  ChartsViewController.swift
//  Berkie
//
//  Created by Gina De La Rosa on 9/10/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//  This view controller will display five chartss

import UIKit
import Charts
import ViewAnimator
import PopupDialog

// MARK: - Charts Data Sets
let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
let moneySavedOverMonths = [200.0, 180.0, 600.0, 100.0, 167.0, 180.0, 300.0, 320.0, 185.0, 260.0, 140.0, 70.0]

class ChartsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chartsTableView: UITableView!
    @IBOutlet weak var infoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartsTableView.alpha = 0 //work around for animation
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presentAnimation()
    }
    
    @IBAction func infoButtonAction(_ sender: Any) {
        infoButton.animatedButton(self.infoButton)
        presentInfoPopup()
    }
    
    
    // MARK: - Animation
    
    func presentAnimation() {
        chartsTableView.alpha = 1
        let animation = [AnimationType.from(direction: .top, offset: 30.0)]
        let cells = chartsTableView.visibleCells
        UIView.animate(views: cells, animations: animation)
        print("Animation presented \(cells.count)")
    }
    
    func presentInfoPopup() {
      
        let title = "Charts Information"
        let message = "These charts will display data related to your financial health. Overtime you will see how you've been able to save, how you spend, and how you budget."
        //let image = UIImage(named: "")
        let popup = PopupDialog(title: title, message: message, image: nil)
    
        let buttonOne = CancelButton(title: "GREAT!") {
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
        return CGFloat(250)
    }

  

}
