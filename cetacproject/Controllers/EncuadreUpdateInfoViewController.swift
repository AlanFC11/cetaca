//
//  EncuadreUpdateInfoViewController.swift
//  cetacproject
//
//  Created by user193544 on 10/14/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit
import Firebase

class EncuadreUpdateInfoViewController: UIViewController {
    var database = Login()
    var user:LoginInfo?
    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var id: UILabel!
    
    @IBOutlet weak var ocupacion: UITextField!
    @IBOutlet weak var religion: UITextField!
    @IBOutlet weak var procedencia: UITextField!
    @IBOutlet weak var domicilio: UITextField!
    @IBOutlet weak var telefono: UITextField!
    @IBOutlet weak var sexo: UITextField!
    @IBOutlet weak var edad: UITextField!
    @IBOutlet weak var estadoCivil: UITextField!
    @IBOutlet weak var celular: UITextField!
    
    @IBOutlet weak var confirm: UISwitch!
    
    
    @IBAction func updateEncuadre(_ sender: Any) {
        if confirm.isOn {
            self.database.updateEncuadre(id: user?.id ?? "", ocupacion: user?.ocupacion ?? "", religion: user?.religion ?? "", procedencia: user?.procedencia ?? "", domicilio: user?.domicilio ?? "", telefono: user?.telefono_casa ?? "", sexo: user?.sexo ?? "", edad: user?.edad ?? 0, estadoCivil: user?.estado_civil ?? "", celular: user?.celular ?? "")
            createAlertSuccess(title: "Éxito", message: "El formato de encuadre fue actualizado exitosamente")
        }else{
            self.createAlert(title: "Advertencia", message: "Confirma que desea actualizar los datos")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        nombre.text = user?.nombre
        id.text = user?.id
        ocupacion.text = user?.ocupacion
        religion.text = user?.religion
        procedencia.text = user?.procedencia
        domicilio.text = user?.domicilio
        telefono.text = user?.telefono_casa
        sexo.text = user?.sexo
        edad.text =  String(user?.edad ?? 0)
        estadoCivil.text = user?.estado_civil
        celular.text = user?.celular
        
    }
    
    func createAlert(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
    }
    func createAlertSuccess (title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        var viewControllerA: UIViewController?

        for  vc in (self.navigationController?.viewControllers ?? []) {
            if vc.isKind(of: SearchUsersViewController.self) {
                  viewControllerA = vc
                  break
            }
        }
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in self.navigationController?.popToViewController(viewControllerA ?? UIViewController(), animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
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
