//
//  Encuadre.swift
//  cetacproject
//
//  Created by user194050 on 10/7/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import Foundation
import Firebase

struct Encuadre: Codable {
    let name, job, religion, procedencia, domicilio, house_number, cel_number, estado_civil, referido, motivo, ekr, sexo: String
    let edad: Int

    init(name:String, job:String, religion:String, procedencia:String, domicilio: String, house_number: String, cel_number:String, estadocivil:String, referido:String, motivo:String, ekr:String, sexo: String, edad: Int){
        self.name = name
        self.job = job
        self.religion = religion
        self.procedencia = procedencia
        self.domicilio = domicilio
        self.house_number = house_number
        self.cel_number = cel_number
        self.estado_civil = estadocivil
        self.referido = referido
        self.motivo = motivo
        self.ekr = ekr
        self.sexo = sexo
        self.edad = edad
    }
        
    init(aDoc: DocumentSnapshot){
        self.name = aDoc.get("nombre") as? String ?? ""
        self.job = aDoc.get("trabajo") as? String ?? ""
        self.religion = aDoc.get("religion") as? String ?? ""
        self.procedencia = aDoc.get("procedencia") as? String ?? ""
        self.domicilio = aDoc.get("domicilio") as? String ?? ""
        self.house_number = aDoc.get("telefono casa") as? String ?? ""
        self.cel_number = aDoc.get("telefono celular") as? String ?? ""
        self.estado_civil = aDoc.get("estado civil") as? String ?? ""
        self.referido = aDoc.get("referido") as? String ?? ""
        self.motivo = aDoc.get("motivo") as? String ?? ""
        self.ekr = aDoc.get("ekr") as? String ?? ""
        self.edad = aDoc.get("edad") as? Int ?? -1
        self.sexo = aDoc.get("sexo") as? String ?? ""
    }
}
