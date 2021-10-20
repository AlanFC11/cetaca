//
//  ReportesViewController.swift
//  cetacproject
//
//  Created by user194050 on 10/17/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit

class ReportesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate
{
    var typeOfChart = ""
    var tipodeGraph: Int?
    var dias = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
    var meses: KeyValuePairs = [
        "Enero": "01",
        "Febrero": "02",
        "Marzo": "03",
        "Abril": "04",
        "Mayo": "5",
        "Junio": "6",
        "Julio": "7",
        "Agosto": "8",
        "Septiembre": "9",
        "Octubre": "10",
        "Noviembre": "11",
        "Diciembre": "12"
    ]
    var anios: KeyValuePairs = ["2006": "06", "2007": "07", "2008": "08","2009": "09","2010": "10","2011": "11","2012": "12","2013": "13","2014": "14","2015": "15","2016": "16","2017": "17","2018": "18","2019": "19","2020": "20","2021": "21","2022": "22","2023": "23","2024": "24","2025": "25","2026": "26"]
    
    @IBOutlet weak var inicioPicker: UIButton!
    @IBOutlet weak var finalPicker: UIButton!
    
    
    var mostrarInicio: String?
    var mostrarFinal: String?
    var diaInicio: String?
    var mesInicio: String?
    var anioInicio: String?
    var fechaInicio_: String?
    var diaFinal: String?
    var mesFinal: String?
    var anioFinal: String?
    var fechaFinal_: String?
    
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    
    var dia1Selec = 0
    var dia2Selec = 0
    var mes1Selec = 0
    var mes2Selec = 0
    var anio1Selec = 0
    var anio2Selec = 0
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if(component == 0){
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
            label.text = Array(dias)[row]
            label.sizeToFit()
            return label

        }else if(component == 1){
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
            label.text = Array(meses)[row].key
            label.sizeToFit()
            return label
        }else{
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
            label.text = Array(self.anios)[row].key
            label.sizeToFit()
            return label
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0){
            return dias.count
        }else if(component == 1){
            return meses.count
        }else{
            return anios.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 60
    }
    
    @IBAction func inicioPopup(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.selectRow(dia1Selec, inComponent: 0, animated: false)
        pickerView.selectRow(mes1Selec, inComponent: 1, animated: false)
        pickerView.selectRow(anio1Selec, inComponent: 2, animated: false)
        
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Selecciona una fecha de inicio", message: "", preferredStyle: .actionSheet)
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (UIAlertAction) in
        }))
        alert.addAction(UIAlertAction(title: "Seleccionar", style: .default, handler: { (UIAlertAction) in
            self.dia1Selec = pickerView.selectedRow(inComponent: 0)
            self.mes1Selec = pickerView.selectedRow(inComponent: 1)
            self.anio1Selec = pickerView.selectedRow(inComponent: 2)
            let selected = Array(self.dias)[self.dia1Selec]
            let selected1 = Array(self.meses)[self.mes1Selec].key
            let selected2 = Array(self.anios)[self.anio1Selec].key
            print(selected)
            print(selected1)
            print(selected2)
            self.diaInicio = selected
            self.mesInicio = Array(self.meses)[self.mes1Selec].value
            self.anioInicio = Array(self.anios)[self.anio1Selec].value
            let name = selected+"/"+selected1+"/"+selected2
            self.inicioPicker.setTitle(name, for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func finalPopup(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.selectRow(dia2Selec, inComponent: 0, animated: false)
        pickerView.selectRow(mes2Selec, inComponent: 1, animated: false)
        pickerView.selectRow(anio2Selec, inComponent: 2, animated: false)
        
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Selecciona una fecha final", message: "", preferredStyle: .actionSheet)
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (UIAlertAction) in
        }))
        alert.addAction(UIAlertAction(title: "Seleccionar", style: .default, handler: { (UIAlertAction) in
            self.dia2Selec = pickerView.selectedRow(inComponent: 0)
            self.mes2Selec = pickerView.selectedRow(inComponent: 1)
            self.anio2Selec = pickerView.selectedRow(inComponent: 2)
            let selected = Array(self.dias)[self.dia2Selec]
            let selected1 = Array(self.meses)[self.mes2Selec].key
            let selected2 = Array(self.anios)[self.anio2Selec].key
            print(selected)
            print(selected1)
            print(selected2)
            self.diaFinal = selected
            self.mesFinal = Array(self.meses)[self.mes2Selec].value
            self.anioFinal = Array(self.anios)[self.anio2Selec].value
            let name = selected+"/"+selected1+"/"+selected2
            self.finalPicker.setTitle(name, for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func genero(_ sender: UIButton) {
        self.tipodeGraph = 1
        self.typeOfChart = "genero"
        let dia1 = Array(self.dias)[self.dia1Selec]
        let dia2 = Array(self.meses)[self.mes1Selec].value
        let dia3 = Array(self.anios)[self.anio1Selec].value
        
        self.fechaInicio_ = dia2 + "/" + dia1 + "/" + dia3
        
        let mes1 = Array(self.dias)[self.dia2Selec]
        let mes2 = Array(self.meses)[self.mes2Selec].value
        let mes3 = Array(self.anios)[self.anio2Selec].value
        
        self.fechaFinal_ = mes2 + "/" + mes1 + "/" + mes3
        
        let meses1 = Array(self.meses)[self.mes1Selec].key
        let meses2 = Array(self.meses)[self.mes2Selec].key
        let anios1 = Array(self.anios)[self.anio1Selec].key
        let anios2 = Array(self.anios)[self.anio2Selec].key
        
        self.mostrarInicio = "Inicio: " + dia1 + "/" + meses1 + "/" + anios1
        self.mostrarFinal = "Final: " + mes1 + "/" + meses2 + "/" + anios2
    }
    
    @IBAction func tanatologos(_ sender: UIButton) {
        self.tipodeGraph = 2
        self.typeOfChart = "userTanat"
        let dia1 = Array(self.dias)[self.dia1Selec]
        let dia2 = Array(self.meses)[self.mes1Selec].value
        let dia3 = Array(self.anios)[self.anio1Selec].value
        
        self.fechaInicio_ = dia2 + "/" + dia1 + "/" + dia3
        print(fechaInicio_)
        let mes1 = Array(self.dias)[self.dia2Selec]
        let mes2 = Array(self.meses)[self.mes2Selec].value
        let mes3 = Array(self.anios)[self.anio2Selec].value
        
        self.fechaFinal_ = mes2 + "/" + mes1 + "/" + mes3
        print(fechaFinal_)
        let meses1 = Array(self.meses)[self.mes1Selec].key
        let meses2 = Array(self.meses)[self.mes2Selec].key
        let anios1 = Array(self.anios)[self.anio1Selec].key
        let anios2 = Array(self.anios)[self.anio2Selec].key
        
        self.mostrarInicio = "Inicio: " + dia1 + "/" + meses1 + "/" + anios1
        self.mostrarFinal = "Final: " + mes1 + "/" + meses2 + "/" + anios2
        print(mostrarInicio)
        print(mostrarFinal)
    }
    
    @IBAction func motivos_(_ sender: UIButton) {
        self.tipodeGraph = 3
        self.typeOfChart = "despliegueMotivos"
        let dia1 = Array(self.dias)[self.dia1Selec]
        let dia2 = Array(self.meses)[self.mes1Selec].value
        let dia3 = Array(self.anios)[self.anio1Selec].value
        
        self.fechaInicio_ = dia2 + "/" + dia1 + "/" + dia3
        print(fechaInicio_)
        let mes1 = Array(self.dias)[self.dia2Selec]
        let mes2 = Array(self.meses)[self.mes2Selec].value
        let mes3 = Array(self.anios)[self.anio2Selec].value
        
        self.fechaFinal_ = mes2 + "/" + mes1 + "/" + mes3
        print(fechaFinal_)
        let meses1 = Array(self.meses)[self.mes1Selec].key
        let meses2 = Array(self.meses)[self.mes2Selec].key
        let anios1 = Array(self.anios)[self.anio1Selec].key
        let anios2 = Array(self.anios)[self.anio2Selec].key
        
        self.mostrarInicio = "Inicio: " + dia1 + "/" + meses1 + "/" + anios1
        self.mostrarFinal = "Final: " + mes1 + "/" + meses2 + "/" + anios2
        print(mostrarInicio)
        print(mostrarFinal)
        
    }
    
    @IBAction func CuotaGlobalChart(_ sender: Any) {
        typeOfChart = "CuotaGlobal"
        let dia1 = Array(self.dias)[self.dia1Selec]
        let dia2 = Array(self.meses)[self.mes1Selec].value
        let dia3 = Array(self.anios)[self.anio1Selec].value
        
        self.fechaInicio_ = dia2 + "/" + dia1 + "/" + dia3
        print(fechaInicio_)
        let mes1 = Array(self.dias)[self.dia2Selec]
        let mes2 = Array(self.meses)[self.mes2Selec].value
        let mes3 = Array(self.anios)[self.anio2Selec].value
        
        self.fechaFinal_ = mes2 + "/" + mes1 + "/" + mes3
        print(fechaFinal_)
        let meses1 = Array(self.meses)[self.mes1Selec].key
        let meses2 = Array(self.meses)[self.mes2Selec].key
        let anios1 = Array(self.anios)[self.anio1Selec].key
        let anios2 = Array(self.anios)[self.anio2Selec].key
        
        self.mostrarInicio = "Inicio: " + dia1 + "/" + meses1 + "/" + anios1
        self.mostrarFinal = "Final: " + mes1 + "/" + meses2 + "/" + anios2
    }
    
    @IBAction func IntervencionesChart(_ sender: Any) {
        typeOfChart = "Intervenciones"
        let dia1 = Array(self.dias)[self.dia1Selec]
        let dia2 = Array(self.meses)[self.mes1Selec].value
        let dia3 = Array(self.anios)[self.anio1Selec].value
        
        self.fechaInicio_ = dia2 + "/" + dia1 + "/" + dia3
        print(fechaInicio_)
        let mes1 = Array(self.dias)[self.dia2Selec]
        let mes2 = Array(self.meses)[self.mes2Selec].value
        let mes3 = Array(self.anios)[self.anio2Selec].value
        
        self.fechaFinal_ = mes2 + "/" + mes1 + "/" + mes3
        print(fechaFinal_)
        let meses1 = Array(self.meses)[self.mes1Selec].key
        let meses2 = Array(self.meses)[self.mes2Selec].key
        let anios1 = Array(self.anios)[self.anio1Selec].key
        let anios2 = Array(self.anios)[self.anio2Selec].key
        
        self.mostrarInicio = "Inicio: " + dia1 + "/" + meses1 + "/" + anios1
        self.mostrarFinal = "Final: " + mes1 + "/" + meses2 + "/" + anios2
    }
    @IBAction func ServiciosChart(_ sender: Any) {
        typeOfChart = "Servicios"
        let dia1 = Array(self.dias)[self.dia1Selec]
        let dia2 = Array(self.meses)[self.mes1Selec].value
        let dia3 = Array(self.anios)[self.anio1Selec].value
        
        self.fechaInicio_ = dia2 + "/" + dia1 + "/" + dia3
        print(fechaInicio_)
        let mes1 = Array(self.dias)[self.dia2Selec]
        let mes2 = Array(self.meses)[self.mes2Selec].value
        let mes3 = Array(self.anios)[self.anio2Selec].value
        
        self.fechaFinal_ = mes2 + "/" + mes1 + "/" + mes3
        print(fechaFinal_)
        let meses1 = Array(self.meses)[self.mes1Selec].key
        let meses2 = Array(self.meses)[self.mes2Selec].key
        let anios1 = Array(self.anios)[self.anio1Selec].key
        let anios2 = Array(self.anios)[self.anio2Selec].key
        
        self.mostrarInicio = "Inicio: " + dia1 + "/" + meses1 + "/" + anios1
        self.mostrarFinal = "Final: " + mes1 + "/" + meses2 + "/" + anios2
    }
    @IBAction func CuotaTanatChart(_ sender: Any) {
        typeOfChart = "CuotaTanat"
        let dia1 = Array(self.dias)[self.dia1Selec]
        let dia2 = Array(self.meses)[self.mes1Selec].value
        let dia3 = Array(self.anios)[self.anio1Selec].value
        
        self.fechaInicio_ = dia2 + "/" + dia1 + "/" + dia3
        print(fechaInicio_)
        let mes1 = Array(self.dias)[self.dia2Selec]
        let mes2 = Array(self.meses)[self.mes2Selec].value
        let mes3 = Array(self.anios)[self.anio2Selec].value
        
        self.fechaFinal_ = mes2 + "/" + mes1 + "/" + mes3
        print(fechaFinal_)
        let meses1 = Array(self.meses)[self.mes1Selec].key
        let meses2 = Array(self.meses)[self.mes2Selec].key
        let anios1 = Array(self.anios)[self.anio1Selec].key
        let anios2 = Array(self.anios)[self.anio2Selec].key
        
        self.mostrarInicio = "Inicio: " + dia1 + "/" + meses1 + "/" + anios1
        self.mostrarFinal = "Final: " + mes1 + "/" + meses2 + "/" + anios2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let nextView = segue.destination as! CreateReportViewController
        nextView.tipodeGraph = self.tipodeGraph ?? 0
        nextView.fechaInicio = self.fechaInicio_
        nextView.fechaFinal = self.fechaFinal_
        print(self.mostrarFinal)
        print(self.mostrarInicio)

        nextView.paraMostrarFinal = self.mostrarFinal
        nextView.paraMostrarInicio = self.mostrarInicio
        nextView.typeOfChart = typeOfChart
        
    }
    

}
