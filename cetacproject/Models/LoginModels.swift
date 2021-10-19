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
    let nombre, ocupacion, religion, procedencia, domicilio, telefono_casa, celular, estado_civil, sexo, referido, motivo: String
    let edad: Int
    /*
    init(nombre:String, desc:String){
        self.nombre = nombre
        self.desc  = desc
        id = "1234"
    }
 */
    init(id:String, nombre:String, ocupacion:String, religion:String, procedencia:String, domicilio:String, telefono_casa:String, celular:String, estado_civil:String, edad:Int, sexo:String, referido:String, motivo:String){
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
        self.motivo = motivo
    }
    init(aDoc: DocumentSnapshot){
        self.id = aDoc.documentID
        self.nombre = aDoc.get("nombre") as? String ?? ""
        self.ocupacion  = aDoc.get("trabajo") as? String ?? ""
        self.religion = aDoc.get("religion") as? String ?? ""
        self.procedencia = aDoc.get("procedencia") as? String ?? ""
        self.domicilio = aDoc.get("domicilio") as? String ?? ""
        self.telefono_casa = aDoc.get("telefono casa") as? String ?? ""
        self.celular = aDoc.get("telefono celular") as? String ?? ""
        self.estado_civil = aDoc.get("estado civil") as? String ?? ""
        self.edad = aDoc.get("edad") as? Int ?? 0
        self.sexo = aDoc.get("sexo") as? String ?? ""
        self.referido = aDoc.get("referido") as? String ?? ""
        self.motivo = aDoc.get("motivo") as? String ?? ""
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

struct Sesion: Codable{
    let idTanatologo, idUsuario, evaluacion, fecha, herramienta, intervencion, motivo, servicio: String
    let cuota, numeroSesion, tipoSesion: Int
    init(idTanatologo: String, idUsuario: String, evaluacion: String, fecha: String, herramienta: String, intervencion: String, motivo: String, servicio: String, cuota: Int, numeroSesion: Int, tipoSesion: Int){
        self.idTanatologo = idTanatologo
        self.idUsuario = idUsuario
        self.evaluacion = evaluacion
        self.fecha = fecha
        self.herramienta = herramienta
        self.intervencion = intervencion
        self.motivo = motivo
        self.servicio = servicio
        self.cuota = cuota
        self.numeroSesion = numeroSesion
        self.tipoSesion = tipoSesion
    }
    init(aDoc: DocumentSnapshot){
        self.idTanatologo = aDoc.get("IDtanatologo") as? String ?? ""
        self.idUsuario = aDoc.get("IDusuario") as? String ?? ""
        self.evaluacion = aDoc.get("evaluacion") as? String ?? ""
        self.fecha = aDoc.get("fecha") as? String ?? ""
        self.herramienta = aDoc.get("herramienta") as? String ?? ""
        self.intervencion = aDoc.get("intervencion") as? String ?? ""
        self.motivo = aDoc.get("motivo") as? String ?? ""
        self.servicio = aDoc.get("servicio") as? String ?? ""
        self.cuota = aDoc.get("cuota") as? Int ?? 0
        self.numeroSesion = aDoc.get("numero de sesion") as? Int ?? 0
        self.tipoSesion = aDoc.get("tipo de sesion") as? Int ?? 0
        
    }
}
typealias Sesiones = [Sesion]
