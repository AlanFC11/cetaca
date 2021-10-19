//
//  UserController.swift
//  cetacproject
//
//  Created by user194050 on 10/5/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import Foundation
import Firebase

    
class UserController{
    
    let db = Firestore.firestore()
    /*
    func fetchServicios(completion: @escaping (Result<Servicios, Error>) -> Void){
        
//        let servicios = [Servicio(nombre: "Uno", desc: "Desc Uno")]
        var servicios = [Servicio]()
        db.collection("servicios").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
              
                for document in querySnapshot!.documents {
                    var s = Servicio(aDoc: document)
                    servicios.append(s)
                }
                completion(.success(servicios))
            }
        }
       
    }
    func deleteServicio(registroID:String, completion: @escaping (Result<String, Error>) -> Void){
        
        db.collection("servicios").document(registroID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
                completion(.failure(err))
            } else {
                print("Document successfully removed!")
                completion(.success("Document successfully removed!"))
            }
        }
    }
    */
    func insertUser(newUser:User, completion: @escaping (Result<String, Error>) -> Void){
        
        var ref: DocumentReference? = nil
        ref = db.collection("Cuentas").addDocument(data: [
            "nombre": newUser.nombre,
            "mail": newUser.mail,
            "password": newUser.password,
            "permisos": newUser.permisos
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(.failure(err))
            } else {
                completion(.success("Exito"))
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
