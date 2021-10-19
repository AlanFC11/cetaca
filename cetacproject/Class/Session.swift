//
//  Session.swift
//  cetacproject
//
//  Created by user194050 on 10/7/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import Foundation
import Firebase

struct Session: Codable {
    let sesNum, cuota, tipo: Int
    let fecha, IDTanatologo, IDUsuario, motivo, servicio, intervencion, herramienta, evaluacion: String
    
    init(sesNum: Int, cuota:Int, tipo: Int, IDTanatologo: String, IDUsuario: String, motivo: String, servicio: String, intervencion: String, herramienta: String, evaluacion: String){
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        self.fecha = formatter.string(from: currentDate)
        self.sesNum = sesNum
        self.cuota = cuota
        self.tipo = tipo
        self.IDTanatologo = IDTanatologo
        self.IDUsuario = IDUsuario
        self.motivo = motivo
        self.servicio = servicio
        self.intervencion = intervencion
        self.herramienta = herramienta
        self.evaluacion = evaluacion
    }
    
    init(aDoc: DocumentSnapshot){
        self.IDUsuario = aDoc.get("IDusuario") as? String ?? ""
        self.fecha = aDoc.get("fecha") as? String ?? ""
        self.sesNum = aDoc.get("numero de sesion") as? Int ?? -1
        self.cuota = aDoc.get("cuota") as? Int ?? -1
        self.tipo = aDoc.get("tipo de sesion") as? Int ?? -1
        self.IDTanatologo = aDoc.get("IDtanatologo") as? String ?? ""
        self.motivo = aDoc.get("motivo") as? String ?? ""
        self.servicio = aDoc.get("servicio") as? String ?? ""
        self.intervencion = aDoc.get("intervencion") as? String ?? ""
        self.herramienta = aDoc.get("herramienta") as? String ?? ""
        self.evaluacion = aDoc.get("evaluacion") as? String ?? ""
    }
}
