//
//  HorizontalTableViewCell.swift
//  Berkie
//
//  Created by Gina De La Rosa on 9/10/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//

import UIKit
import Charts

class HorizontalTableViewCell: UITableViewCell {

    @IBOutlet weak var horizontalView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func createChart() {
        // Data point setup
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<months.count {
            let dataEntry = BarChartDataEntry.init(x: Double(i), y: Double(moneySavedOverMonths[i]))
            dataEntries.append(dataEntry)
        }
        
        //Configure
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "")
        chartDataSet.colors = [UIColor(red: 37/255, green: 68/255, blue: 65/255, alpha: 1), UIColor(red: 67/255, green: 170/255, blue: 139/255, alpha: 1)]
        chartDataSet.drawValuesEnabled = true
        chartDataSet.valueTextColor = UIColor.black
        chartDataSet.drawIconsEnabled = true
        let chartData = BarChartData(dataSet: chartDataSet)
        
        //Axis setup
        let horizontalGraph = HorizontalBarChartView()
        horizontalGraph.frame = CGRect(x: 0, y: 0, width: horizontalView.bounds.width, height: horizontalView.bounds.height)
        horizontalGraph.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        horizontalGraph.xAxis.labelPosition = .bottom
        horizontalGraph.chartDescription?.text = "Money Earned"
        horizontalGraph.leftAxis.enabled = true
        horizontalGraph.xAxis.drawGridLinesEnabled = false
        horizontalGraph.rightAxis.drawGridLinesEnabled = false
        horizontalGraph.leftAxis.drawLabelsEnabled = true
        horizontalGraph.data = chartData
        
        horizontalView.addSubview(horizontalGraph)
    }

}
