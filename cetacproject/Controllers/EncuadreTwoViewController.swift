//
//  EncuadreTwoViewController.swift
//  cetacproject
//
//  Created by user194050 on 10/7/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit

class EncuadreTwoViewController: UIViewController, UITextFieldDelegate {
    var encuadre:Encuadre?
    var encuadreControl = EncuadreController()
    
    var tanaID: String?
    var nombre: String?
    var job: String?
    var domicilio: String?
    var procedencia: String?
    var religion: String?
    var edad: Int?
    var sexo: String?
    var userID: String?
    
    @IBOutlet weak var ekr: UITextField!
    @IBOutlet weak var motivo: UITextField!
    @IBOutlet weak var referido: UITextField!
    @IBOutlet weak var telcel: UITextField!
    @IBOutlet weak var telcasa: UITextField!
    @IBOutlet weak var estadocivil: UITextField!
    /*
    @IBAction func Tap(_ sender: UITapGestureRecognizer) {
        nombreText.resignFirstResponder()
        emailText.resignFirstResponder()
        primerpassText.resignFirstResponder()
        segunpassText.resignFirstResponder()
        cuentaText.resignFirstResponder()
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        telcel.delegate = self
        telcasa.delegate = self
        estadocivil.delegate = self
        referido.delegate = self
        motivo.delegate = self
        ekr.delegate = self
    }
    
    @IBAction func deleteKey(_ sender: UITapGestureRecognizer) {
        ekr.resignFirstResponder()
        motivo.resignFirstResponder()
        referido.resignFirstResponder()
        telcel.resignFirstResponder()
        telcasa.resignFirstResponder()
        estadocivil.resignFirstResponder()
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
        /*
        encuadreControl.getID(){ (result) in
            switch result{
            case .success(let id):self.userID! = id; print(id)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a los servicios")
            }
        }
        */
        self.encuadre = Encuadre(name: nombre!, job: job!, religion: religion!, procedencia: procedencia!, domicilio: domicilio!, house_number: telcasa.text!, cel_number: telcel.text!, estadocivil: estadocivil.text!, referido: referido.text!, motivo: motivo.text!, ekr: ekr.text!, sexo: self.sexo!, edad: self.edad!)
        
        print("UserID:")
        
        
        encuadreControl.insertEncuadre(newEncuadre: self.encuadre!,newID: self.userID!){ (result) in
            switch result{
            /*case .success(let retorno):self.displayExito(title: retorno, detalle: "Se insertó el registro")*/
            case .success(let retorno):self.displayExito(title: "Exito", detalle: "Cuenta agregada exitosamente")
            case .failure(let error):self.displayError(error, title: "No se puedo agregar encuadre")
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView = segue.destination as! AddSonViewController
        
        nextView.userID = self.userID
        nextView.tanaID = self.tanaID
        nextView.nombre = self.nombre
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
