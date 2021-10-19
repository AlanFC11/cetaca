//
//  ChartsViewController.swift
//  cetacproject
//
//  Created by user193544 on 10/17/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit
import Firebase
import Charts
import TinyConstraints

class ChartsViewController: UIViewController {
    
    var typeOfChart = ""
    
    var database = Login()
    var sessionsData = [Sesion]()
    @IBOutlet weak var chartView: UIView!
    
    lazy var pieChart: PieChartView = {
        let pieChartView = PieChartView()
        return pieChartView
    }()

    lazy var barChart: BarChartView = {
        let barChartView = BarChartView()
        return barChartView
    }()
 
    lazy var cuotaGChart: LineChartView = {
       let view = LineChartView()
        return view
    }()
    
    lazy var cuotaTanatChart: LineChartView = {
       let view = LineChartView()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        database.fetchSessions{ (result) in
            switch result{
            case .success(let sesiones):self.pieChartUpdate(with: sesiones)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a los servicios")
            }
            
        }
        if typeOfChart == "CuotaGlobal"{
            chartView.addSubview(cuotaGChart)
            cuotaGChart.center(in: chartView)
            cuotaGChart.width(to: chartView)
            cuotaGChart.heightToWidth(of: chartView)
        }else if typeOfChart == "CuotaTanat"{
            chartView.addSubview(cuotaTanatChart) //agrega la gráfica a la vista
            cuotaTanatChart.center(in: chartView) //centra la gráfica en la vista
            cuotaTanatChart.width(to: chartView) //define el ancho de la gráfica
            cuotaTanatChart.heightToWidth(of: chartView) //definel el alto de la gráfica
        }else if typeOfChart == "Servicios"{
            chartView.addSubview(pieChart) //agrega la gráfica a la vista
            pieChart.center(in: chartView) //centra la gráfica en la vista
            pieChart.width(to: chartView) //define el ancho de la gráfica
            pieChart.heightToWidth(of: chartView) //definel el alto de la gráfica
        }else if typeOfChart == "Intervenciones"{
            chartView.addSubview(barChart) //agrega la gráfica a la vista
            barChart.center(in: chartView) //centra la gráfica en la vista
            barChart.width(to: chartView) //define el ancho de la gráfica
            barChart.heightToWidth(of: chartView) //definel el alto de la gráfica
        }
        
        
    }
    
    func pieChartUpdate (with sesiones: Sesiones) {//future home of pie chart code
        if typeOfChart == "Servicios"{
            
        let entry1 = PieChartDataEntry(value: Double(sesiones.filter{$0.servicio == "Acompañamiento"}.count), label: "Acompañamiento")
        let entry2 = PieChartDataEntry(value: Double(sesiones.filter{$0.servicio == "Holístico"}.count), label: "Holísticos")
        let entry3 = PieChartDataEntry(value: Double(sesiones.filter{$0.servicio == "Alternativa"}.count), label: "Alternativas")
        let dataSet = PieChartDataSet(entries: [entry1, entry2, entry3], label: "# tipo de servicio utilizado")
        dataSet.colors = ChartColorTemplates.joyful()
        let data = PieChartData(dataSet: dataSet)
        pieChart.data = data
        pieChart.chartDescription?.text = ""
        pieChart.holeColor = UIColor.clear
        pieChart.chartDescription?.textColor = UIColor.black
        pieChart.legend.textColor = UIColor.black//This must stay at end of function
        pieChart.notifyDataSetChanged()
            
    }else if typeOfChart == "Intervenciones"{
        
        let entry1bar = BarChartDataEntry(x: 1, y: Double(sesiones.filter{$0.intervencion == "Tanatología"}.count))
        let entry2bar = BarChartDataEntry(x: 2, y:  Double(sesiones.filter{$0.intervencion == "Acompañamiento individual"}.count))
        let entry3bar = BarChartDataEntry(x: 3, y:  Double(sesiones.filter{$0.intervencion == "Acompañamiento grupal"}.count))
        let entry4bar = BarChartDataEntry(x: 4, y:  Double(sesiones.filter{$0.intervencion == "Logoterapia"}.count))
        let entry5bar = BarChartDataEntry(x: 5, y:  Double(sesiones.filter{$0.intervencion == "Mindfulness"}.count))
        let entry6bar = BarChartDataEntry(x: 6, y:  Double(sesiones.filter{$0.intervencion == "Aromaterapia y musicoterapia"}.count))
        let entry7bar = BarChartDataEntry(x: 7, y:  Double(sesiones.filter{$0.intervencion == "Cristaloterapia"}.count))
        let entry8bar = BarChartDataEntry(x: 8, y:  Double(sesiones.filter{$0.intervencion == "Reiki"}.count))
        let entry9bar = BarChartDataEntry(x: 9, y: Double(sesiones.filter{$0.intervencion == "Biomagnetismo"}.count))
        let entry10bar = BarChartDataEntry(x: 10, y:  Double(sesiones.filter{$0.intervencion == "Angeloterapia"}.count))
        let entry11bar = BarChartDataEntry(x: 11, y:  Double(sesiones.filter{$0.intervencion == "Cama térmica de Jade"}.count))
        let entry12bar = BarChartDataEntry(x: 12, y:  Double(sesiones.filter{$0.intervencion == "Flores de Bach"}.count))
        let entry13bar = BarChartDataEntry(x: 13, y:  Double(sesiones.filter{$0.intervencion == "Brisas ambientales"}.count))
        var arreglo = [BarChartDataEntry]()
        arreglo.append(entry1bar)
        arreglo.append(entry2bar)
        arreglo.append(entry3bar)
        arreglo.append(entry4bar)
        arreglo.append(entry5bar)
        arreglo.append(entry6bar)
        arreglo.append(entry7bar)
        arreglo.append(entry8bar)
        arreglo.append(entry9bar)
        arreglo.append(entry10bar)
        arreglo.append(entry11bar)
        arreglo.append(entry12bar)
        arreglo.append(entry13bar)
        let dataSetbar = BarChartDataSet(entries: arreglo, label: "# tipo de intervención")
        dataSetbar.colors = ChartColorTemplates.joyful()
        let databar = BarChartData(dataSet: dataSetbar)
        barChart.data = databar
        barChart.drawGridBackgroundEnabled = false
        barChart.chartDescription?.text = ""
        barChart.chartDescription?.textColor = UIColor.black
        let intervenciones = ["","Tanatología", "Ac.Ind.","Ac.Grup.", "Logoterapia", "Mindfulness", "Aroma. y music.", "Cristaloterapia", "Reiki","Biomag.","Angeloterapia","Cama tér.","Flores Bach","Brisas amb."]
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: intervenciones)
        barChart.legend.textColor = UIColor.black//This must stay at end of function
        barChart.notifyDataSetChanged()
        
    }
        else if typeOfChart == "CuotaGlobal"{
            
        let allYears = sesiones.map{$0.fecha.components(separatedBy: "/")[2]}
        let uniqueYears: Set<String> = Set(allYears)
        let uYears = Array(uniqueYears)
        var entriesPerYear = [ChartDataEntry]()
        for i in uniqueYears{  // hacer la suma de cada año
            var sum = 0
            let oneYearResults = sesiones.filter{$0.fecha.components(separatedBy: "/")[2] == i}
            for o in oneYearResults{
                sum += o.cuota
            }
            let entry = ChartDataEntry(x: Double(i) ?? 0, y: Double(sum))
            entriesPerYear.append(entry)
        }
        let dataSetGlobalCuota = LineChartDataSet(entries: entriesPerYear, label: "Cuota de recuperación global| Valor en y: Pesos MXN | Valor en x: Año")
        dataSetGlobalCuota.colors = ChartColorTemplates.pastel()
        let dataGlobalCuota = LineChartData(dataSet: dataSetGlobalCuota)
        cuotaGChart.data = dataGlobalCuota
        cuotaTanatChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: uYears)
        cuotaGChart.notifyDataSetChanged()
        }
        
        else if typeOfChart == "CuotaTanat"{
            
        let allTanats = sesiones.map{$0.idTanatologo}
        let uniqueTanats: Set<String> = Set(allTanats)
        let uTanats = Array(uniqueTanats)
        print(uTanats)
        var entriesPerTanat = [ChartDataEntry]()
        for i in uniqueTanats{  // hacer la suma de cada año
            var sum = 0
            let oneTanatResults = sesiones.filter{$0.idTanatologo == i}
            for o in oneTanatResults{
                sum += o.cuota
            }
            let entry = ChartDataEntry(x: Double(i) ?? 0, y: Double(sum))
            entriesPerTanat.append(entry)
        }
        let dataSetTanatCuota = LineChartDataSet(entries: entriesPerTanat, label: "Cuota de recuperación por tanatólogo")
        dataSetTanatCuota.colors = ChartColorTemplates.pastel()
        let dataTanatCuota = LineChartData(dataSet: dataSetTanatCuota)
        cuotaTanatChart.data = dataTanatCuota
        cuotaTanatChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: uTanats)
        cuotaTanatChart.notifyDataSetChanged()
        }
    }
    func displayError(_ error: Error, title: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
