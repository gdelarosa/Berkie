//
//  VerticalTableViewCell.swift
//  Berkie
//
//  Created by Gina De La Rosa on 9/10/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//

import UIKit
import Charts
import ViewAnimator

class VerticalTableViewCell: UITableViewCell {

    @IBOutlet weak var verticalView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func createChart() {
        //Retrieve data
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<months.count {
            let dataEntry = BarChartDataEntry.init(x: Double(i), y: Double(moneySavedOverMonths[i]))
            dataEntries.append(dataEntry)
        }
        
        //Configure settings for the bar
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Money Saved")
       
        chartDataSet.colors = [UIColor(red: 219/255, green: 80/255, blue: 74/255, alpha: 1),
                               UIColor(red: 255/255, green: 111/255, blue: 89/255, alpha: 1)]
        let chartData = BarChartData(dataSet: chartDataSet)
        
        //Settings for the chart view
        let newGraph = BarChartView()
        newGraph.frame = CGRect(x: 0, y: 0, width: verticalView.bounds.width, height: verticalView.bounds.height)
        newGraph.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        newGraph.xAxis.labelPosition = .bottom
        newGraph.chartDescription?.text = ""
        newGraph.rightAxis.enabled = false
        newGraph.xAxis.drawGridLinesEnabled = false
        newGraph.leftAxis.drawGridLinesEnabled = false
        newGraph.data = chartData
        
        verticalView.addSubview(newGraph)
    }

}
