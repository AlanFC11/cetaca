//
//  Son.swift
//  cetacproject
//
//  Created by user194050 on 10/7/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import Foundation
import Firebase

struct Son: Codable {
    let edad: Int
    let sexo, IDUsuario: String
    
    init(sexo:String, IDUsuario: String, edad:Int){
        self.edad = edad
        self.sexo = sexo
        self.IDUsuario = IDUsuario
    }
    
    init(aDoc: DocumentSnapshot){
        self.IDUsuario = aDoc.get("userID") as? String ?? ""
        self.sexo = aDoc.get("sexo") as? String ?? ""
        self.edad = aDoc.get("edad") as? Int ?? -1
    }
}
