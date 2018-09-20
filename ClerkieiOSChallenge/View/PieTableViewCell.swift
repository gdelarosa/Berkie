//
//  PieTableViewCell.swift
//  Berkie
//
//  Created by Gina De La Rosa on 9/10/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//

import UIKit
import Charts

class PieTableViewCell: UITableViewCell {

    @IBOutlet weak var pieView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func createChart() {
        
        
        // Data point setup
        var dataEntries: [PieChartDataEntry] = []
        let moneySavedByQuarter = [280.0, 300.0, 500.0, 170.0]
        
        for i in 0..<moneySavedByQuarter.count {
            let dataEntry = PieChartDataEntry.init(value: moneySavedByQuarter[i], label: nil)
            
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "Total Saved")
        chartDataSet.colors = [UIColor.init(red: 37/255, green: 68/255, blue: 65/255, alpha: 1)];
        chartDataSet.sliceSpace = 2
        chartDataSet.valueTextColor = UIColor.black
        chartDataSet.valueLineColor = UIColor.black
        chartDataSet.xValuePosition = .insideSlice
        chartDataSet.yValuePosition = .outsideSlice
  
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let pieGraph = PieChartView()
        
        pieGraph.chartDescription?.text = ""
        pieGraph.legend.enabled = true
        
        pieGraph.frame = CGRect(x: 0, y: 0, width: pieView.bounds.width, height: pieView.bounds.height)
        pieGraph.data = chartData
      
        pieGraph.animate(xAxisDuration: 0.5, yAxisDuration: 0.5)
        
        
        pieView.addSubview(pieGraph)
    }

}
