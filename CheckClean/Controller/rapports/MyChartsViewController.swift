//
//  MyChartsViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 29/06/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit
import Charts
import Firebase

class MyChartsViewController: UIViewController {

    var ref: DatabaseReference!
    var chartsDates = [Date]()
    var chartsNotes = [Int]()
    @IBOutlet weak var lineCharts: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineCharts.noDataText = "Pas encore de donnes"
        lineCharts.dragEnabled = true
        lineCharts.setScaleEnabled(true)
        lineCharts.pinchZoomEnabled = true
       
        
        //recup des controls
        if let idCurrentBulding =  UserDefaults.standard.string(forKey: "BuldingId"){
            
            //creation du dateFormateur
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            
            self.ref = Database.database().reference(withPath: "Controls-Bulding")
               ref.queryOrderedByKey().queryEqual(toValue: idCurrentBulding as String) .observe(.value) { (data) in
               
                for controls in data.children {
                    let controls = controls as! DataSnapshot
                    
                    for control in controls.children {
                        let ctr = control as! DataSnapshot
                        let dateString = ctr.childSnapshot(forPath: "date").value as! String
                        let date = dateFormatter.date(from: dateString)
                        let note = ctr.childSnapshot(forPath: "note").value  as! Int
                        if let date = date {
                            self.chartsDates.append(date)
                            self.chartsNotes.append(note)
                            self.setDatas(dataPoints: self.chartsDates, values: self.chartsNotes)
                            
                            
                        }
                    }
                }
            }
        }
        self.lineCharts.animate(xAxisDuration: 3, yAxisDuration: 3)
        lineCharts.delegate = self
        
    }
}
extension MyChartsViewController: ChartViewDelegate {
    
    func setDatas(dataPoints: [Date], values: [Int]) {
        
        var dataEntries = [ChartDataEntry]()
        
        for i in 0..<dataPoints.count {
        
            let charEntry = ChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(charEntry)
            
        }
        let linear = LineChartDataSet(values: dataEntries, label: "Controles")
        let data = LineChartData(dataSet: linear)
        lineCharts.data = data
    }
}




