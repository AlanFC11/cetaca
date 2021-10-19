//
//  TanaSessionViewController.swift
//  cetacproject
//
//  Created by user194050 on 10/7/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit

class TanaSessionViewController: UIViewController,UITextFieldDelegate {
    var userID: String?
    var sesNum: Int?
    var tanatologoID: String?
    var tipo: Int?
    
    let control = SessionController()
    @IBOutlet weak var nombreUsuario: UITextField!
    @IBOutlet weak var encuadre: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        encuadre.isEnabled = false
        let path = Bundle.main.path(forResource: "id", ofType: "txt")
        let url = URL(fileURLWithPath: path!)
        
        let string = try! NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
        let id = string.components(separatedBy: ":").last!.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "}", with: "")
        self.tanatologoID = id
        
        nombreUsuario.delegate = self
    }
    
    @IBAction func didChange(_ sender: UISwitch)
    {
        if(sender.isOn){
            encuadre.isEnabled = true
            self.sesNum = 1
            self.tipo = 1
        }else{
            encuadre.isEnabled = false
            self.tipo = 2
            self.sesNum = -1
        }
    }
    
    @IBAction func closeKey(_ sender: UITapGestureRecognizer) {
        nombreUsuario.resignFirstResponder()
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
    
    @IBAction func SearchUser(_ sender: UIButton) {
        let nombre = nombreUsuario.text
        if(!nombre!.isEmpty){
            
            control.getID(name: nombreUsuario.text!){ (result) in
                switch result{
                /*case .success(let retorno):self.displayExito(title: retorno, detalle: "Se insertó el registro")*/
                case .success(let newID):if (newID != "null"){self.userID = newID; print(newID); self.displayExito(title: "Encontrado", detalle: "El usuario a sido agregado con exito")}else{self.displayExito(title: "Error", detalle: "El usuario no se pudo encontrar")}
                case .failure(let error):self.displayError(error, title: "No se pudo encontrar usuario")
                }
            }
        
        }else{
            displayExito(title: "Error", detalle: "Ingresa un nombre de usuario")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    /*
     var sesNum: Int?
     var tanatologoID: String?
     var tipo: Int?
     */
    
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is SessionOneViewController){
            let nextView = segue.destination as! SessionOneViewController
            nextView.userID = self.userID
            nextView.sesNum = self.sesNum
            nextView.tanatologoID = self.tanatologoID
            nextView.tipo = self.tipo
            nextView.nombre = self.nombreUsuario.text!
        }else if (segue.destination is EncuadreOneViewController){
            let encuadre = segue.destination as! EncuadreOneViewController
            encuadre.tanaID = self.tanatologoID
        }
    }
    

}
