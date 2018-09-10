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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createChart() {
        // Retrieve data
        var dataEntries: [PieChartDataEntry] = []
        for i in 0..<months.count {
            let dataEntry = PieChartDataEntry.init(value: moneySavedOverMonths[i], label: months[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "Money Saved")
        //Configure settings
        chartDataSet.colors = [UIColor.init(red: 204/255, green: 230/255, blue: 244/255, alpha: 1), UIColor(red: 75/255, green: 163/255, blue: 195/255, alpha: 1)];
        chartDataSet.xValuePosition = .insideSlice;
        chartDataSet.yValuePosition = .outsideSlice;
        chartDataSet.sliceSpace = 1
        chartDataSet.selectionShift = 6.66
        chartDataSet.valueColors = [UIColor.gray]
        chartDataSet.valueLineColor = UIColor.black
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let newGraph = PieChartView()
        newGraph.usePercentValuesEnabled = true
        newGraph.chartDescription?.text = "Money Saved"
        newGraph.chartDescription?.font = UIFont.systemFont(ofSize: 10.0)
        newGraph.legend.enabled = false
        newGraph.frame = CGRect(x: 0, y: 0, width: pieView.bounds.width, height: pieView.bounds.height)
        newGraph.entryLabelFont = UIFont.systemFont(ofSize: 6.0)
        
        newGraph.data = chartData
        
        pieView.addSubview(newGraph)
    }

}
