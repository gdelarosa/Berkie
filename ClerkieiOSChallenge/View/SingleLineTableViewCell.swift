//
//  SingleLineTableViewCell.swift
//  Berkie
//
//  Created by Gina De La Rosa on 9/10/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//

import UIKit
import Charts

class SingleLineTableViewCell: UITableViewCell {

    @IBOutlet weak var singleLineView: UIView!
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
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<months.count {
            let dataEntry = ChartDataEntry.init(x: Double(i), y: moneySavedOverMonths[i])
            dataEntries.append(dataEntry)
        }
        
        //Configure settings for the line
        let chartDataSet = LineChartDataSet.init(values: dataEntries, label: "Money Saved")
        chartDataSet.colors = [UIColor(red: 137/255, green: 4/255, blue: 61/255, alpha: 1)]
        chartDataSet.circleRadius = 2.0
        chartDataSet.circleColors = [UIColor.gray]
        let chartData = LineChartData(dataSet: chartDataSet)
        
        //Settings for the chart view
        let newGraph = LineChartView()
        newGraph.frame = CGRect(x: 0, y: 0, width: singleLineView.bounds.width, height: singleLineView.bounds.height)
        newGraph.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        newGraph.xAxis.labelPosition = .bottom
        newGraph.chartDescription?.text = ""
        newGraph.rightAxis.enabled = false
        newGraph.xAxis.drawGridLinesEnabled = false
        newGraph.leftAxis.drawGridLinesEnabled = false
        newGraph.data = chartData
        
        singleLineView.addSubview(newGraph)
    }

}
