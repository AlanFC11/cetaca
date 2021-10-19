//
//  EncuadreController.swift
//  cetacproject
//
//  Created by user194050 on 10/7/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import Foundation
import Firebase

    
class EncuadreController{
    
    let db = Firestore.firestore()
    var userID: String?
    
    func getID(completion: @escaping (Result<String, Error>) -> Void){
        
//        let servicios = [Servicio(nombre: "Uno", desc: "Desc Uno")]
        db.collection("UsuarioInfo").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
                var count = 0
                for i in querySnapshot!.documents {
                    count = count+1
                }
                count = count+1
                self.userID = "US0" + String(count)
                print("aqui se establece el id:")
                print(self.userID)
                completion(.success(self.userID!))
            }
        }
       
    }
    
    func insertEncuadre(newEncuadre:Encuadre, newID: String, completion: @escaping (Result<String, Error>) -> Void){
        
        self.db.collection("UsuarioInfo").document(newID).setData([
            "nombre": newEncuadre.name,
            "trabajo": newEncuadre.job,
            "religion": newEncuadre.religion,
            "procedencia": newEncuadre.procedencia,
            "domicilio": newEncuadre.domicilio,
            "telefono casa": newEncuadre.cel_number,
            "telefono celular": newEncuadre.house_number,
            "estado civil": newEncuadre.estado_civil,
            "referido": newEncuadre.referido,
            "motivo": newEncuadre.motivo,
            "ekr": newEncuadre.ekr,
            "sexo": newEncuadre.sexo,
            "edad": newEncuadre.edad
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(.failure(err))
            } else {
                completion(.success("Encuadre agregado"))
            }
        }
    }
    /*
    func updateServicio(updateServicio:Servicio, completion: @escaping (Result<String, Error>) -> Void){
        db.collection("servicios").document(updateServicio.id).updateData([
            "nombre": updateServicio.nombre, "desc":updateServicio.desc
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(.failure(err))
            } else {
                print("Document successfully updated")
                completion(.success("Document successfully updated"))
            }
        }
    }
 */
}
