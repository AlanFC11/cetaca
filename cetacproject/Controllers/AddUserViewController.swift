//
//  AddUserViewController.swift
//  cetacproject
//
//  Created by user194050 on 10/5/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate
{
    var userControlador = UserController()
    
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var permisosSelec = 0
    
    
    @IBOutlet weak var CrearButton: UIButton!
    @IBOutlet weak var segunpassText: UITextField!
    @IBOutlet weak var primerpassText: UITextField!
    @IBOutlet weak var nombreText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var permisosPicker: UIButton!
    
    let permisos =
        [
            "Tanatólogo": 1,
            "Subadministrador": 2,
            "Administrador": 3
        ]
    
    var user:User?
    var permit: String?
    
    @IBAction func Tap(_ sender: UITapGestureRecognizer) {
        nombreText.resignFirstResponder()
        emailText.resignFirstResponder()
        primerpassText.resignFirstResponder()
        segunpassText.resignFirstResponder()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        label.text = Array(permisos)[row].key
        label.sizeToFit()
        return label
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return permisos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 60
    }
    
    @IBAction func permisosPopup(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.selectRow(permisosSelec, inComponent: 0, animated: false)
        
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Selecciona un tipo de cuenta", message: "", preferredStyle: .actionSheet)
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (UIAlertAction) in
        }))
        alert.addAction(UIAlertAction(title: "Seleccionar", style: .default, handler: { (UIAlertAction) in
            self.permisosSelec = pickerView.selectedRow(inComponent: 0)
            let selected = Array(self.permisos)[self.permisosSelec].key
            self.permit = selected
            let name = selected
            self.permisosPicker.setTitle(name, for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailText.delegate = self
        nombreText.delegate = self
        primerpassText.delegate = self
        segunpassText.delegate = self
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
    
    @IBAction func Crear(_ sender: UIButton) {
        let tamanio = primerpassText.text!
        if(primerpassText.text == segunpassText.text && tamanio.count >= 8){
            let n = nombreText.text!
            let e = emailText.text!
            let p = primerpassText.text!
            let permit = Array(permisos)[permisosSelec].value
            
            self.user = User(nombre: n, mail: e, password: p, permisos: permit)
        
        userControlador.insertUser(newUser: self.user!){ (result) in
            switch result{
            /*case .success(let retorno):self.displayExito(title: retorno, detalle: "Se insertó el registro")*/
            case .success(let retorno):self.displayExito(title: "Exito", detalle: "Cuenta agregada exitosamente")
            case .failure(let error):self.displayError(error, title: "No se puedo agregar cuenta")
            }
        }
        }else{
            self.displayExito(title: "Error", detalle: "Contraseña incorrecta")
        }
        self.nombreText.text = ""
        self.emailText.text = ""
        self.primerpassText.text = ""
        self.segunpassText.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
