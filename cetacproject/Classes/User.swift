//
//  User.swift
//  cetacproject
//
//  Created by user194050 on 10/5/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import Foundation
import Firebase

struct User: Codable {
    let permisos: Int
    let mail, nombre, password: String
    
    init(nombre:String, mail:String, password:String, permisos:Int){
        self.nombre = nombre
        self.mail  = mail
        self.password = password
        self.permisos = permisos
    }
    
    init(aDoc: DocumentSnapshot){
        self.nombre = aDoc.get("nombre") as? String ?? ""
        self.mail = aDoc.get("mail") as? String ?? ""
        self.password = aDoc.get("password") as? String ?? ""
        self.permisos = aDoc.get("permisos") as? Int ?? -1
    }
}
