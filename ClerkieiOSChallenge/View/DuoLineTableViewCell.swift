//
//  DuoLineTableViewCell.swift
//  Berkie
//
//  Created by Gina De La Rosa on 9/10/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//

import UIKit
import Charts

class DuoLineTableViewCell: UITableViewCell {

    @IBOutlet weak var duoLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    let moneySavedYearTwo = [280.0, 100.0, 500.0, 170.0, 108.0, 100.0, 600.0, 300.0, 150.0, 200.0, 200.0, 90.0]
    
    func createChart() {
        
       
        
        var dataEntries: [ChartDataEntry] = []
        var dataEntries1: [ChartDataEntry] = []
        
        for i in 0..<months.count {
            let dataEntry = ChartDataEntry.init(x: Double(i), y: moneySavedOverMonths[i])
            dataEntries.append(dataEntry)
            let dataEntry1 = ChartDataEntry.init(x: Double(i), y: moneySavedYearTwo[i])
            dataEntries1.append(dataEntry1)
        }
        
        //Configure settings for both lines separately
        let chartDataSet = LineChartDataSet.init(values: dataEntries, label: "Money Saved ")
        let chartDataSet1 = LineChartDataSet.init(values: dataEntries1, label: "Money Spent")
        chartDataSet.colors = [UIColor(red: 47/255, green: 230/255, blue: 222/255, alpha: 1)]
        chartDataSet1.colors = [UIColor(red: 28/255, green: 48/255, blue: 65/255, alpha: 1)]
        chartDataSet.circleRadius = 2.0
        chartDataSet1.circleRadius = 2.0
        chartDataSet.circleColors = [UIColor.gray]
        chartDataSet1.circleColors = [UIColor.lightGray]
        let chartData = LineChartData.init(dataSets: [chartDataSet, chartDataSet1])
        
        //Axis setup
        let duoLineGraph = LineChartView()
        duoLineGraph.frame = CGRect(x: 0, y: 0, width: duoLineView.bounds.width, height: duoLineView.bounds.height)
        duoLineGraph.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        duoLineGraph.xAxis.labelPosition = .bottom
        duoLineGraph.chartDescription?.text = ""
        duoLineGraph.chartDescription?.font = UIFont.systemFont(ofSize: 16.0)
        duoLineGraph.rightAxis.enabled = false
        duoLineGraph.xAxis.drawGridLinesEnabled = false
        duoLineGraph.leftAxis.drawGridLinesEnabled = false
        duoLineGraph.leftAxis.drawLabelsEnabled = true 
        duoLineGraph.data = chartData
        duoLineGraph.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        
        duoLineView.addSubview(duoLineGraph)
    }

}
