//
//  AddSonViewController.swift
//  cetacproject
//
//  Created by user194050 on 10/7/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit

class AddSonViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    let control = SonController()
    @IBOutlet weak var edad: UITextField!
    @IBOutlet weak var estado: UISwitch!
    @IBOutlet weak var EndButton: UIButton!
    
    var tanaID: String?
    var userID: String?
    var nombre: String?
    
    let sexos = ["femenino", "masculino", "otro"]
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var sexoSelec = 0
    var sexoRespuesta: String?
    
    @IBOutlet weak var sexoPicker: UIButton!
    @IBAction func sexoPopup(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.selectRow(sexoSelec, inComponent: 0, animated: false)
        
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Selecciona un sexo", message: "", preferredStyle: .actionSheet)
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (UIAlertAction) in
        }))
        alert.addAction(UIAlertAction(title: "Seleccionar", style: .default, handler: { (UIAlertAction) in
            self.sexoSelec = pickerView.selectedRow(inComponent: 0)
            let selected = Array(self.sexos)[self.sexoSelec]
            self.sexoRespuesta = selected
            let name = selected
            self.sexoPicker.setTitle(name, for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
            label.text = Array(sexos)[row]
            label.sizeToFit()
            return label
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sexos.count
        }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 60
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edad.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didChange(_ sender: UISwitch)
    {
        if(sender.isOn){
            EndButton.isEnabled = true
        }else{
            EndButton.isEnabled = false
        }
    }
    
    @IBAction func hideKey(_ sender: UITapGestureRecognizer) {
        edad.resignFirstResponder()
    }
    
    func displayError(_ error: Error, title: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Descartar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    func displayExito(title: String, detalle:String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: detalle, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Descartar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    @IBAction func agregar(_ sender: Any) {
        let n = Int(edad.text!)
        let son = Son(sexo: self.sexoRespuesta!, IDUsuario: userID!, edad: n!)
        control.insertSon(newSon: son){ (result) in
            switch result{
            /*case .success(let retorno):self.displayExito(title: retorno, detalle: "Se insertó el registro")*/
            case .success(let retorno):self.displayExito(title: "Exito", detalle: "Hijo agregado exitosamente")
            case .failure(let error):self.displayError(error, title: "No se pudo agregar hijo")
            }
        }
            self.edad.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView = segue.destination as! SessionOneViewController
        nextView.tanatologoID = self.tanaID
        nextView.userID = self.userID
        nextView.sesNum = 1
        nextView.nombre = self.nombre
        nextView.tipo = 1
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}
