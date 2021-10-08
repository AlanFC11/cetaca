//
//  LoginModels.swift
//  cetacproject
//
//  Created by user193544 on 10/5/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import Foundation
import Firebase

struct LoginInfo: Codable {
    let id:String
    let nombre, ocupacion, religion, procedencia, domicilio, telefono_casa, celular, estado_civil, sexo, referido: String
    let edad: Int
    /*
    init(nombre:String, desc:String){
        self.nombre = nombre
        self.desc  = desc
        id = "1234"
    }
 */
    init(id:String, nombre:String, ocupacion:String, religion:String, procedencia:String, domicilio:String, telefono_casa:String, celular:String, estado_civil:String, edad:Int, sexo:String, referido:String){
        self.id = id
        self.nombre = nombre
        self.ocupacion  = ocupacion
        self.religion = religion
        self.procedencia = procedencia
        self.domicilio = domicilio
        self.telefono_casa = telefono_casa
        self.celular = celular
        self.estado_civil = estado_civil
        self.edad = edad
        self.sexo = sexo
        self.referido = referido
    }
    init(aDoc: DocumentSnapshot){
        self.id = aDoc.documentID
        self.nombre = aDoc.get("nombre") as? String ?? ""
        self.ocupacion  = aDoc.get("ocupacion") as? String ?? ""
        self.religion = aDoc.get("religion") as? String ?? ""
        self.procedencia = aDoc.get("procedencia") as? String ?? ""
        self.domicilio = aDoc.get("domicilio") as? String ?? ""
        self.telefono_casa = aDoc.get("telefono_casa") as? String ?? ""
        self.celular = aDoc.get("celular") as? String ?? ""
        self.estado_civil = aDoc.get("estado_civil") as? String ?? ""
        self.edad = aDoc.get("edad") as? Int ?? 0
        self.sexo = aDoc.get("sexo") as? String ?? ""
        self.referido = aDoc.get("referido") as? String ?? ""
    }
}

typealias LoginInfos = [LoginInfo]

struct Cuentas: Codable{
    let id: String
    let mail, nombre, password: String
    let permisos: Int
    init(id:String, mail:String, nombre:String, password:String, permisos:Int){
        self.id = id
        self.mail = mail
        self.nombre = nombre
        self.password = password
        self.permisos = permisos
    }
    init(aDoc: DocumentSnapshot) {
        self.id = aDoc.documentID
        self.mail = aDoc.get("mail") as? String ?? ""
        self.nombre = aDoc.get("nombre") as? String ?? ""
        self.password = aDoc.get("password") as? String ?? ""
        self.permisos = aDoc.get("permisos") as? Int ?? 0
    }
}
typealias CuentasInfo = [Cuentas]
