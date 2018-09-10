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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createChart() {
        // Retrieve data
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<months.count {
            let dataEntry = BarChartDataEntry.init(x: Double(i), y: Double(moneySavedOverMonths[i]))
            dataEntries.append(dataEntry)
        }
        
        //Configure settings for the bar
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Money Saved")
        chartDataSet.colors = [UIColor(red: 37/255, green: 68/255, blue: 65/255, alpha: 1), UIColor(red: 67/255, green: 170/255, blue: 139/255, alpha: 1)]
        chartDataSet.drawValuesEnabled = true
        chartDataSet.valueTextColor = UIColor.black
        chartDataSet.drawIconsEnabled = true
        let chartData = BarChartData(dataSet: chartDataSet)
        
        //Settings for the chart view
        let newGraph = HorizontalBarChartView()
        newGraph.frame = CGRect(x: 0, y: 0, width: horizontalView.bounds.width, height: horizontalView.bounds.height)
        newGraph.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        newGraph.xAxis.labelPosition = .bottom
        newGraph.chartDescription?.text = ""
        newGraph.leftAxis.enabled = false
        newGraph.xAxis.drawGridLinesEnabled = false
        newGraph.rightAxis.drawGridLinesEnabled = false
        newGraph.data = chartData
        
        horizontalView.addSubview(newGraph)
    }

}
