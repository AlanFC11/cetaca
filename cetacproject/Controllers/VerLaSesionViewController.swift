//
//  VerLaSesionViewController.swift
//  cetacproject
//
//  Created by user194050 on 10/20/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit

class VerLaSesionViewController: UIViewController {
    var service: String?
    var cost: String?
    var tool: String?
    var comment: String?
    var intervention: String?
    var motive: String?
    var name: String?
    var iduser: String?
    var typeSesion: String?
    var numSesion: String?
    
    @IBOutlet weak var TipoSesion: UILabel!
    @IBOutlet weak var numeroSesion: UILabel!
    @IBOutlet weak var expediente: UILabel!
    @IBOutlet weak var servicio: UILabel!
    @IBOutlet weak var cuota: UILabel!
    @IBOutlet weak var comentairo: UITextField!
    @IBOutlet weak var hwrramienta: UILabel!
    @IBOutlet weak var intervencion: UILabel!
    @IBOutlet weak var motivo: UILabel!
    @IBOutlet weak var Nombre: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.servicio.text = "servicio: " + service!
        self.cuota.text = "Cuota: " + cost!
        self.comentairo.text = "Evaluación: " + comment!
        self.intervencion.text = "Intervención: " + intervention!
        self.motivo.text = "Motivo: " + motive!
        self.Nombre.text = "Nombre: " + name!
        self.hwrramienta.text = "Herramienta: " + tool!
        self.TipoSesion.text = "Sesion: " + typeSesion!
        self.numeroSesion.text = "Sesion número: " + numSesion!
        self.expediente.text = iduser!
        // Do any additional setup after loading the view.
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
