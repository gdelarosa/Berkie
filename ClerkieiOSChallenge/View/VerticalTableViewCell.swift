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
        //Data point setup
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<months.count {
            let dataEntry = BarChartDataEntry.init(x: Double(i), y: Double(moneySavedOverMonths[i]))
            dataEntries.append(dataEntry)
        }
        
        //Configure settings for the bar
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Money Earned")
       
        chartDataSet.colors = [UIColor(red: 219/255, green: 80/255, blue: 74/255, alpha: 1),
                               UIColor(red: 255/255, green: 111/255, blue: 89/255, alpha: 1)]
        let chartData = BarChartData(dataSet: chartDataSet)
        
        //Axis setup
        let verticalGraph = BarChartView()
        verticalGraph.frame = CGRect(x: 0, y: 0, width: verticalView.bounds.width, height: verticalView.bounds.height)
        verticalGraph.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        verticalGraph.xAxis.labelPosition = .bottom
        verticalGraph.chartDescription?.text = ""
        verticalGraph.rightAxis.enabled = false
        verticalGraph.xAxis.drawGridLinesEnabled = false
        verticalGraph.leftAxis.drawGridLinesEnabled = false
        verticalGraph.leftAxis.drawLabelsEnabled = true 
        verticalGraph.data = chartData
        
        verticalView.addSubview(verticalGraph)
    }

}
