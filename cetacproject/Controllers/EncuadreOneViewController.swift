//
//  EncuadreOneViewController.swift
//  cetacproject
//
//  Created by user194050 on 10/7/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit

class EncuadreOneViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate
{
    @IBOutlet weak var scrollview: UIScrollView!
    var id:String?
    var tanaID:String?
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var job: UITextField!
    @IBOutlet weak var domicilio: UITextField!
    @IBOutlet weak var procedencia: UITextField!
    @IBOutlet weak var religion: UITextField!
    
    @IBOutlet weak var edad: UITextField!
    
    let sexos = ["femenino", "masculino", "otro"]
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var sexoSelec = 0
    var sexoRespuesta: String?
    let control = EncuadreController()
    
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
    
    func displayError(_ error: Error, title: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Descartar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.control.getID(){ (result) in
            switch result{
            /*case .success(let retorno):self.displayExito(title: retorno, detalle: "Se insertó el registro")*/
            case .success(let newID):self.id = newID
            case .failure(let error):self.displayError(error, title: "No se pudo agregar nuevo id")
            }
        }
        nombre.delegate = self
        job.delegate = self
        religion.delegate = self
        procedencia.delegate = self
        domicilio.delegate = self
        edad.delegate = self
        registerForKeyboardNotifications()
        // Do any additional setup after loading the view.
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWasShown(_ notification: NSNotification) {
        guard let info = notification.userInfo,
            let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }

        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size

        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height+100, right: 0.0)
        scrollview.contentInset = contentInsets
    }

    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollview.contentInset = contentInsets
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        nombre.resignFirstResponder()
        job.resignFirstResponder()
        domicilio.resignFirstResponder()
        procedencia.resignFirstResponder()
        religion.resignFirstResponder()
        edad.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView = segue.destination as! EncuadreTwoViewController
        
        nextView.domicilio = domicilio.text!
        nextView.job = job.text!
        nextView.nombre = nombre.text!
        nextView.procedencia = procedencia.text!
        nextView.religion = religion.text!
        nextView.edad = Int(edad.text!)
        nextView.sexo = self.sexoRespuesta
        nextView.userID = self.id
        nextView.tanaID = self.tanaID
    }
    

}
