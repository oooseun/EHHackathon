//
//  ChartViewController.swift
//  Automatic Feeder
//
//  Created by Qi Liao on 1/28/17.
//  Copyright © 2017 Qi Liao. All rights reserved.
//

import Foundation
import UIKit
import Charts

class ChartViewController: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
    let weight = [20.0, 19.8, 19.0, 18.2, 17.9, 17.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChartView.noDataText = "testing"
        
        
        setChart(dataPoints: months, values: weight)
        
        // Do any additional setup after loading the view.
    }
    
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Weight")
        lineChartDataSet.setColor(UIColor.blue)
        //    lineChartDataSet.drawCubicEnabled = true
        lineChartDataSet.mode = .cubicBezier
        lineChartDataSet.drawCirclesEnabled = true
        lineChartDataSet.lineWidth = 1.0
        lineChartDataSet.circleRadius = 5.0
        lineChartDataSet.highlightColor = UIColor.red
        lineChartDataSet.drawHorizontalHighlightIndicatorEnabled = true
        lineChartDataSet.drawFilledEnabled = true
        
        var dataSets = [IChartDataSet]()
        dataSets.append(lineChartDataSet)
        
        let lineChartData = LineChartData(dataSets: dataSets)
        
        lineChartView.data = lineChartData
        
        self.lineChartView.xAxis.granularity = 1
        self.lineChartView.xAxis.valueFormatter = DefaultAxisValueFormatter(block: { (index, _) -> String in
            return self.months[Int(index)]
        })
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        lineChartView.chartDescription?.text = ""
        lineChartView.rightAxis.enabled = false
        
    }
}

