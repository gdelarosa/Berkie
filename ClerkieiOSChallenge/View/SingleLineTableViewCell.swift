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
    
    func createChart() {
        //Data point setup
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<months.count {
            let dataEntry = ChartDataEntry.init(x: Double(i), y: moneySavedOverMonths[i])
            dataEntries.append(dataEntry)
        }
        
        //Configure settings for the line
        let chartDataSet = LineChartDataSet.init(values: dataEntries, label: "Money Spent")
        chartDataSet.colors = [UIColor(red: 137/255, green: 4/255, blue: 61/255, alpha: 1)]
        chartDataSet.circleRadius = 2.0
        chartDataSet.circleColors = [UIColor.gray]
        let chartData = LineChartData(dataSet: chartDataSet)
        
        //Axis setup
        let singleLineGraph = LineChartView()
        singleLineGraph.frame = CGRect(x: 0, y: 0, width: singleLineView.bounds.width, height: singleLineView.bounds.height)
        singleLineGraph.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        singleLineGraph.xAxis.labelPosition = .bottom
        singleLineGraph.chartDescription?.text = ""
        singleLineGraph.rightAxis.enabled = false
        singleLineGraph.xAxis.drawGridLinesEnabled = false
        singleLineGraph.leftAxis.drawGridLinesEnabled = false
        singleLineGraph.leftAxis.drawLabelsEnabled = true 
        singleLineGraph.data = chartData
        
        singleLineView.addSubview(singleLineGraph)
    }

}
