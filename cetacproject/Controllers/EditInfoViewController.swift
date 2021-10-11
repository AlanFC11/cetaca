//
//  EditInfoViewController.swift
//  cetacproject
//
//  Created by user193544 on 10/8/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit
import Firebase

class EditInfoViewController: UIViewController {

    var database = Login()
    
    var cuenta:Cuentas?
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var correo: UILabel!
    //@IBOutlet weak var permisos: UILabel!
    @IBOutlet weak var id: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nombre.text = cuenta?.nombre
        correo.text = cuenta?.mail
        id.text = cuenta?.id
        //permisos.text = cuenta?.permisos
    }
    
    @IBAction func deleteSubAdmin(_ sender: Any!){
        database.deleteUser(id: cuenta?.id ?? "")
        self.createAlert(title: "Éxito", message: "El subadmin se eliminó correctamente")
        
        
    }

    
    func createAlert (title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        var viewControllerA: UIViewController?

        for  vc in (self.navigationController?.viewControllers ?? []) {
            if vc.isKind(of: QuienesSomosViewController.self) {
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
