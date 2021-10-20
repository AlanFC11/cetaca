//
//  SessionOneViewController.swift
//  cetacproject
//
//  Created by user194050 on 10/8/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit

class SessionOneViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate
{
    var userID: String?
    var sesNum: Int?
    var tanatologoID: String?
    var tipo: Int?
    var nombre: String?
    var sesion: Session?
    
    @IBOutlet weak var recuperacion: UITextField!
    @IBOutlet weak var evaluacion: UITextField!
    
    var cause: String?
    var service: String?
    var intervention: String?
    var tool: String?
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var motivoSelec = 0
    var servicioSelec = 0
    var intervencionSelec = 0
    var herramientaSelec = 0

    
    var motivos =
    [
        "Abuso", "Adicción", "Ansiedad", "Baja autoestima", "codependencia", "Comunicación familiar", "Conflicto con hermano", "Conflicto con madre", "Conflicto con padre", "Dependencia", "Divorcio", "Duelo", "Duelo grupal", "Enfermedad", "Enfermedad crónica", "Heridas de la infancia", "identidad de género", "Infertilidad", "Infidelidad", "Intento de suicidio", "Miedo", "Perdida material", "Perdida de identidad", "Perdida laboral", "Realción con padres", "Ruptura de noviazgo", "Estrés", "T.O.C", "Violación", "Violencia familiar", "Violencia psicológica", "Viudez", "Otro"
    ]
    var servicios =
    [
        "Acompañamiento", "Holístico", "Alternativas"
    ]
    var intervenciones =
    [
        "Tanatología", "Acompañamiento individual", "Acompañamiento grupal", "Logoterapia", "Mindfullness", "Aromaterapia/Musicoterapia", "Cristaloterapia", "Reiki", "Biomagnetismo", "Angeloterapia", "Cama de jade", "Flores de Bach", "Brisas ambientales"
    ]
    var herramientas =
    [
        "Contención", "Diálogo", "Ejercicio", "Encuadre", "Infografía", "Dinámica", "Lectura", "Meditación", "Video", "otro"
    ]
    @IBOutlet weak var motivoPicker: UIButton!
    @IBOutlet weak var servicePicker: UIButton!
    @IBOutlet weak var intervencionPicker: UIButton!
    @IBOutlet weak var herramientaPicker: UIButton!
    @IBOutlet weak var nombreUsuario: UILabel!
    @IBOutlet weak var expedienteLabel: UILabel!

    let control = SessionController()
    
    @IBAction func pop(_sender: Any){
        var viewControllerA: UIViewController?

        for  vc in (self.navigationController?.viewControllers ?? []) {
            if vc.isKind(of: LoggedMenuViewController.self) {
                  viewControllerA = vc
                  break
            }
        }
        self.navigationController?.popToViewController(viewControllerA ?? UIViewController(), animated: true)
    }
    
    @IBAction func herramientaPopup(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerViewherramienta = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerViewherramienta.dataSource = self
        pickerViewherramienta.delegate = self
        pickerViewherramienta.tag = 4
        
        pickerViewherramienta.selectRow(herramientaSelec, inComponent: 0, animated: false)
        
        vc.view.addSubview(pickerViewherramienta)
        pickerViewherramienta.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerViewherramienta.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Selecciona una herramienta", message: "", preferredStyle: .actionSheet)
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (UIAlertAction) in
        }))
        alert.addAction(UIAlertAction(title: "Seleccionar", style: .default, handler: { (UIAlertAction) in
            self.herramientaSelec = pickerViewherramienta.selectedRow(inComponent: 0)
            let selected = Array(self.herramientas)[self.herramientaSelec]
            self.tool = selected
            let name = selected
            self.herramientaPicker.setTitle(name, for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    
    @IBAction func intervencionPopup(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerViewintervencion = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerViewintervencion.dataSource = self
        pickerViewintervencion.delegate = self
        pickerViewintervencion.tag = 3
        
        pickerViewintervencion.selectRow(intervencionSelec, inComponent: 0, animated: false)
        
        vc.view.addSubview(pickerViewintervencion)
        pickerViewintervencion.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerViewintervencion.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Selecciona una intervención", message: "", preferredStyle: .actionSheet)
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (UIAlertAction) in
        }))
        alert.addAction(UIAlertAction(title: "Seleccionar", style: .default, handler: { (UIAlertAction) in
            self.intervencionSelec = pickerViewintervencion.selectedRow(inComponent: 0)
            let selected = Array(self.intervenciones)[self.intervencionSelec]
            self.intervention = selected
            let name = selected
            self.intervencionPicker.setTitle(name, for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func servicioPopup(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerViewservicio = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerViewservicio.dataSource = self
        pickerViewservicio.delegate = self
        pickerViewservicio.tag = 2
        
        pickerViewservicio.selectRow(servicioSelec, inComponent: 0, animated: false)
        
        vc.view.addSubview(pickerViewservicio)
        pickerViewservicio.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerViewservicio.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Selecciona un servicio", message: "", preferredStyle: .actionSheet)
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (UIAlertAction) in
        }))
        alert.addAction(UIAlertAction(title: "Seleccionar", style: .default, handler: { (UIAlertAction) in
            self.servicioSelec = pickerViewservicio.selectedRow(inComponent: 0)
            let selected = Array(self.servicios)[self.servicioSelec]
            self.service = selected
            let name = selected
            self.servicePicker.setTitle(name, for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func motivoPopup(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerViewmotivo = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerViewmotivo.dataSource = self
        pickerViewmotivo.delegate = self
        pickerViewmotivo.tag = 1
        
        pickerViewmotivo.selectRow(motivoSelec, inComponent: 0, animated: false)
        
        vc.view.addSubview(pickerViewmotivo)
        pickerViewmotivo.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerViewmotivo.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Selecciona un motivo", message: "", preferredStyle: .actionSheet)
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (UIAlertAction) in
        }))
        alert.addAction(UIAlertAction(title: "Seleccionar", style: .default, handler: { (UIAlertAction) in
            self.motivoSelec = pickerViewmotivo.selectedRow(inComponent: 0)
            let selected = Array(self.motivos)[self.motivoSelec]
            self.cause = selected
            let name = selected
            self.motivoPicker.setTitle(name, for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)

        
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        if(pickerView.tag == 1){
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
            label.text = Array(motivos)[row]
            label.sizeToFit()
            return label
        }else if(pickerView.tag == 2){
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
            label.text = Array(servicios)[row]
            label.sizeToFit()
            return label
        }else if(pickerView.tag == 3){
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
            label.text = Array(intervenciones)[row]
            label.sizeToFit()
            return label
        }else if(pickerView.tag == 4){
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
            label.text = Array(herramientas)[row]
            label.sizeToFit()
            return label
        }else{
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
            label.text = "null"
            label.sizeToFit()
            return label
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 1){
            return motivos.count
        }else if(pickerView.tag == 2){
            return servicios.count
        }else if(pickerView.tag == 3){
            return intervenciones.count
        }else if(pickerView.tag == 4){
            return herramientas.count
        }else{
            return 1
        }
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
    
    func displayExito(title: String, detalle:String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: detalle, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Descartar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nombreUsuario.text = self.nombre
        self.expedienteLabel.text = self.userID
        
        if(self.sesNum != 1){
            self.tipo = 2
            control.getSesNum(name: self.userID!){ (result) in
                switch result{
                /*case .success(let retorno):self.displayExito(title: retorno, detalle: "Se insertó el registro")*/
                case .success(let newSes):self.sesNum = newSes; print(newSes)
                case .failure(let error):self.displayError(error, title: "No se pudo encontrar el numero de sesion")
                }
            }
        }
        evaluacion.delegate = self
        recuperacion.delegate = self
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
        
    
    @IBAction func didChange(_ sender: UISwitch)
    {
        if(sender.isOn){
            self.tipo = 3
        }
    }
    
    @IBAction func eraseKey(_ sender: UITapGestureRecognizer) {
        evaluacion.resignFirstResponder()
        recuperacion.resignFirstResponder()
    }
    
    @IBAction func createSesion(_ sender: UIButton) {
        let motivo = Array(self.motivos)[self.motivoSelec]
        let usuario = self.userID!
        let tanatologo = self.tanatologoID!
        let servicio = Array(self.servicios)[self.servicioSelec]
        let intervencion = Array(self.intervenciones)[self.intervencionSelec]
        let herramienta = Array(self.herramientas)[self.herramientaSelec]
        let evaluacion_ = self.evaluacion.text!
        let cuota = Int(recuperacion.text!)
        let tipo_ = self.tipo!
        let numeroSesion = self.sesNum!
        
        self.sesion = Session(sesNum: numeroSesion, cuota: cuota!, tipo: tipo_, IDTanatologo: tanatologo, IDUsuario: usuario, motivo: motivo, servicio: servicio, intervencion: intervencion, herramienta: herramienta, evaluacion: evaluacion_)
        
        //self.sesion = Session(sesNum: numeroSesion, cuota: cuota, tipo: tipo, IDTanatologo: tanatologo, IDUsuario: user, motivo: motivo, servicio: servicio, intervencion: intervencion, herramienta: herramienta, evaluacion: evaluacion)
        
        control.insertSession(newSession: self.sesion!){ (result) in
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
