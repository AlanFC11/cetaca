//
//  CreateReportViewController.swift
//  cetacproject
//
//  Created by user194050 on 10/17/21.
//  Copyright © 2021 CDT307. All rights reserved.
//


import UIKit
import Firebase
import Foundation
import Charts
import TinyConstraints

class CreateReportViewController: UIViewController, ChartViewDelegate {
    let db = Firestore.firestore()
    var typeOfChart = ""
    
    var database = Login()
    var sessionsData = [Sesion]()
    @IBOutlet weak var chartView: UIView!
    
    lazy var pieChartServicios: PieChartView = {
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
    
    
    lazy var pieChart: PieChartView = {
        var pieChartView = PieChartView()
        return pieChartView
    }()
    
    var usuarios = [Encuadre]()
    var tanatologos = [String: User]()
    var sesiones = [Session]()
    
    var tipodeGraph = 0
    
    var paraMostrarInicio: String?
    var paraMostrarFinal: String?
    var fechaInicio:String?
    var fechaFinal:String?
    
    @IBOutlet weak var vistaGrafica: UIView!
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var fechaI: UILabel!
    @IBOutlet weak var fechaF: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fechaI.text = self.paraMostrarInicio ?? ""
        fechaF.text = self.paraMostrarFinal ?? ""
        
        
        database.fetchSessions{ (result) in
            switch result{
            case .success(let sesiones):self.pieChartUpdate(with: sesiones)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a los servicios")
            }
            
        }

        
        if(typeOfChart == "genero"){
            pieChart.delegate = self
            titulo.text = "Usuarios por sexo"
            //vistaGrafica.addSubview(pieChart)
            chartView.addSubview(pieChart)
            //pieChart.center(in: vistaGrafica)
            pieChart.center(in: chartView)
            //pieChart.width(to: vistaGrafica)
            pieChart.width(to: chartView)
            //pieChart.heightToWidth(of: vistaGrafica)
            pieChart.heightToWidth(of: chartView)
            
            db.collection("Sesion").getDocuments(){ (QuerySnapshot, err) in
                if let err = err {
                    print("Error en base de datos")
                } else {
                    for document in QuerySnapshot!.documents{
                        var s = Session(aDoc: document)
                        self.sesiones.append(s)
                    }
                    print("Se agregaron las sesiones")
                    print(self.sesiones.count)
                    self.obtenerUsuarios()
                }
            }
        }
        else if (typeOfChart == "userTanat")
        {
            pieChart.delegate = self
            titulo.text = "Usuarios por tanatólogo"
            chartView.addSubview(pieChart)
            pieChart.center(in: chartView)
            pieChart.width(to: chartView)
            pieChart.heightToWidth(of: chartView)
            
            db.collection("Cuentas").getDocuments(){ (QuerySnapshot, err) in
                if let err = err {
                    print("Error en base de datos")
                } else {
                    for document in QuerySnapshot!.documents{
                        var s = User(aDoc: document)
                        if(s.permisos == 1){
                            self.tanatologos[document.documentID] = s
                        }
                    }
                    print("Se agregaron los tanatologos")
                    print(self.tanatologos.count)
                    self.db.collection("Sesion").getDocuments(){ (QuerySnapshot, err) in
                        if let err = err {
                            print("Error en base de datos")
                        } else {
                            for document in QuerySnapshot!.documents{
                                var s = Session(aDoc: document)
                                self.sesiones.append(s)
                            }
                            print("Se agregaron las sesiones")
                            print(self.sesiones.count)
                        }
                    }
                    self.obtenerUsuariosTanatologo()
                }
            }
        }else if typeOfChart == "CuotaGlobal"{
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
            chartView.addSubview(pieChartServicios) //agrega la gráfica a la vista
            pieChartServicios.center(in: chartView) //centra la gráfica en la vista
            pieChartServicios.width(to: chartView) //define el ancho de la gráfica
            pieChartServicios.heightToWidth(of: chartView) //definel el alto de la gráfica
        }else if typeOfChart == "Intervenciones"{
            chartView.addSubview(barChart) //agrega la gráfica a la vista
            barChart.center(in: chartView) //centra la gráfica en la vista
            barChart.width(to: chartView) //define el ancho de la gráfica
            barChart.heightToWidth(of: chartView) //definel el alto de la gráfica
        }
        
        
                
    }

    
    func obtenerUsuariosTanatologo(){
        var tant = [String: Int]()
        print("entro a la funcion")
        
        var usuarios__ = [String]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let inicio_ = dateFormatter.date(from: self.fechaInicio!)
        let final_ = dateFormatter.date(from: self.fechaFinal!)
        print("se declararon las funciones")
        
        for (key,value) in self.tanatologos{
            tant[value.nombre] = 0
        }
        
        for sesion in self.sesiones{
            print("entro al for")
            print(sesion.fecha)
            var inter_ = dateFormatter.date(from: sesion.fecha)
            print(type(of: inter_))
            
            if(inter_! >= inicio_! && inter_! <= final_!){
                var nombre = tanatologos[sesion.IDTanatologo]?.nombre
                var valorAnterior = tant[nombre!]
                tant.updateValue(valorAnterior!+1, forKey: nombre!)
            }else{
                print("ninguno cumple")
            }
        }
        var entradas = [PieChartDataEntry]()
        for (key,value) in tant{
            var punto1 = PieChartDataEntry(value: Double(value), label: key)
            entradas.append(punto1)
        }
        
        let dataSet = PieChartDataSet(entries: entradas, label: "Tanatólogos")
        dataSet.colors = ChartColorTemplates.pastel()
        let data = PieChartData(dataSet: dataSet)
        self.pieChart.data = data

        self.pieChart.notifyDataSetChanged()
    }
    
    func obtenerUsuarios()
    {
        print("entro a la funcion")
        var masc = 0
        var fem = 0
        var otro = 0
        var usuarios__ = [String]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let inicio_ = dateFormatter.date(from: self.fechaInicio!)
        let final_ = dateFormatter.date(from: self.fechaFinal!)
        print("se declararon las funciones")
        
        for sesion in self.sesiones{
            print("entro al for")
            print(sesion.fecha)
            var inter_ = dateFormatter.date(from: sesion.fecha)
            print(type(of: inter_))
            
            if(inter_! >= inicio_! && inter_! <= final_! && !usuarios__.contains(sesion.IDUsuario)){
                usuarios__.append(sesion.IDUsuario)
                print("entro al if")
                print(sesion.IDUsuario)
                db.collection("UsuarioInfo").document(sesion.IDUsuario).getDocument(){ (document, error) in
                    if let document = document, document.exists {
                        var encuadre = Encuadre(aDoc: document)
                        print(encuadre.sexo)
                       
                        if(encuadre.sexo == "masculino"){
                            masc = masc+1
                        }else if(encuadre.sexo == "femenino"){
                            fem = fem+1
                        }else{
                            otro = otro+1
                        }
                        print(masc)
                        print(fem)
                        print(otro)
                        var punto1 = PieChartDataEntry(value: Double(masc), label: "masculino")
                        var punto2 = PieChartDataEntry(value: Double(fem), label: "femenino")
                        var punto3 = PieChartDataEntry(value: Double(otro), label: "otro")
                        
                        let dataSet = PieChartDataSet(entries: [punto1, punto2, punto3], label: "Sexos")
                        dataSet.colors = ChartColorTemplates.pastel()
                        let data = PieChartData(dataSet: dataSet)
                        self.pieChart.data = data

                        self.pieChart.notifyDataSetChanged()
                    }else{
                        print("No se encontro documento")
                    }
                }
            }else{
                print("ninguno cumple")
            }
        }
        
        
    }
    func pieChartUpdate (with sesiones: Sesiones) {//future home of pie chart code
        if typeOfChart == "Servicios"{
            
        let entry1 = PieChartDataEntry(value: Double(sesiones.filter{$0.servicio == "Acompañamiento"}.count), label: "Acompañamiento")
        let entry2 = PieChartDataEntry(value: Double(sesiones.filter{$0.servicio == "Holístico"}.count), label: "Holísticos")
        let entry3 = PieChartDataEntry(value: Double(sesiones.filter{$0.servicio == "Alternativas"}.count), label: "Alternativas")
        let dataSet = PieChartDataSet(entries: [entry1, entry2, entry3], label: "# tipo de servicio utilizado")
        dataSet.colors = ChartColorTemplates.joyful()
        let data = PieChartData(dataSet: dataSet)
        pieChartServicios.data = data
        pieChartServicios.chartDescription?.text = ""
        pieChartServicios.holeColor = UIColor.clear
        pieChartServicios.chartDescription?.textColor = UIColor.black
        pieChartServicios.legend.textColor = UIColor.black//This must stay at end of function
        pieChartServicios.notifyDataSetChanged()
            
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


