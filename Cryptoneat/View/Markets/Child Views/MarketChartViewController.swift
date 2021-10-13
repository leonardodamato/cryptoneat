//
//  MarketChartViewController.swift
//  Cryptoneat
//
//  Created by Leonardo D'Amato on 20/9/21.
//

import UIKit
import Charts

class MarketChartViewController: UIViewController {    
    
    var chartView: LineChartView!
    var chartDataEntry: [ChartDataEntry] = []
    var xAxisStrings: [String] = []
    
    ///This variable needs to bet set in MarketViewController, when this View Controller gets instantiated.
    ///It will define whether the chart is for the last 24 hours or not
    ///If it is 'true' we need to show the time in the format "hh:mm" else, we should show a date "dd/MM" or "dd/MM/yy" depending if the year is the same as the current year
    ///
    var is24hChart: Bool?
    
    var data: [MarketChart]
    
    init(data: [MarketChart]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChart()
    }
    
    
    func setUpDataEntries() -> [ChartDataEntry] {
        for item in data {
            
            let entry = ChartDataEntry(x: item.timestamp, y: item.price)
            chartDataEntry.append(entry)
        }
        
        return chartDataEntry
    }
    
    
    func setupChart() {
        if chartView != nil { chartView.removeFromSuperview() }
        
        chartDataEntry = setUpDataEntries()
        
        let line = LineChartDataSet(entries: chartDataEntry)
        line.colors = [Colors.tint]
        line.drawCirclesEnabled = false
        line.lineWidth = 1
        line.drawValuesEnabled = false
        
        let data = LineChartData()
        data.clearValues()
        data.addDataSet(line)
        
        chartView = LineChartView()
        chartView.data = data

        view.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        chartView.scaleXEnabled = true
        chartView.scaleYEnabled = false
    
        chartView.legend.enabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.labelTextColor = .white
        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.rightAxis.labelTextColor = .white
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.leftAxis.drawAxisLineEnabled = false

        
        chartView.drawBordersEnabled = false
        chartView.animate(xAxisDuration: 1)
        chartView.xAxis.labelCount = 3
        chartView.xAxis.valueFormatter = self

        
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            chartView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            chartView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            chartView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),

        ])

    }
}

extension MarketChartViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let is24hChart = is24hChart else { return "Error" }
        
        let date = Date(timeIntervalSince1970: value / 1000)
        
        var format: String {
            if is24hChart {
                return "HH:mm"
            } else {
                let calendar = Calendar.current
                let dateComponents = calendar.dateComponents([.year], from: date)
                let currentComponents = calendar.dateComponents([.year], from: Date())
                
                if dateComponents.year == currentComponents.year {
                    return "dd/MM"
                } else {
                    return "dd/MM/yy"
                }
            }
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateString = formatter.string(from: date)
        return dateString
    }
}
