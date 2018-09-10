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
        // Initialization code
    }

    func createChart() {
        // Data point setup
        var dataEntries: [PieChartDataEntry] = []
        for i in 0..<months.count {
            let dataEntry = PieChartDataEntry.init(value: moneySavedOverMonths[i], label: months[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "Total Spending")
        //Configure settings
        chartDataSet.colors = [UIColor.init(red: 204/255, green: 230/255, blue: 244/255, alpha: 1), UIColor(red: 75/255, green: 163/255, blue: 195/255, alpha: 1)];
        chartDataSet.xValuePosition = .insideSlice;
        chartDataSet.yValuePosition = .outsideSlice;
        chartDataSet.sliceSpace = 1
        chartDataSet.selectionShift = 6.66
        chartDataSet.valueColors = [UIColor.gray]
        chartDataSet.valueLineColor = UIColor.black
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let pieGraph = PieChartView()
        pieGraph.usePercentValuesEnabled = true
        pieGraph.chartDescription?.text = "Total Spending"
        pieGraph.chartDescription?.font = UIFont.systemFont(ofSize: 10.0)
        pieGraph.legend.enabled = false
        pieGraph.frame = CGRect(x: 0, y: 0, width: pieView.bounds.width, height: pieView.bounds.height)
        pieGraph.entryLabelFont = UIFont.systemFont(ofSize: 6.0)
        
        pieGraph.data = chartData
        
        pieView.addSubview(pieGraph)
    }

}
