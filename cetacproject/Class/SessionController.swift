//
//  SessionController.swift
//  cetacproject
//
//  Created by user194050 on 10/7/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import Foundation
import Firebase

    
class SessionController{
    
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
    */
    
    func getSesNum(name: String, completion: @escaping (Result<Int,Error>) -> Void){
        db.collection("Sesion").whereField("IDusuario", isEqualTo: name)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    completion(.failure(err))
                }else{
                    var cnt = 0
                    for _ in querySnapshot!.documents{
                        cnt = cnt + 1
                    }
                    cnt = cnt + 1
                    completion(.success(cnt))
                }
            }
    }
    
    func getID(name: String, completion: @escaping (Result<String,Error>) -> Void){
        db.collection("UsuarioInfo").whereField("nombre", isEqualTo: name)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    completion(.failure(err))
                }else{
                    var user: String?
                    for document in querySnapshot!.documents{
                        user = document.documentID
                    }
                    if (user != nil){
                        completion(.success(user!))
                    }else {
                        completion(.success("null"))
                    }
                }
    }
    }
    
    func insertSession(newSession:Session, completion: @escaping (Result<String, Error>) -> Void){
        
        var ref: DocumentReference? = nil
        ref = db.collection("Sesion").addDocument(data: [
            "fecha": newSession.fecha,
            "numero de sesion": newSession.sesNum,
            "cuota": newSession.cuota,
            "tipo de sesion": newSession.tipo,
            "IDtanatologo": newSession.IDTanatologo,
            "IDusuario": newSession.IDUsuario,
            "motivo": newSession.motivo,
            "servicio": newSession.servicio,
            "intervencion": newSession.intervencion,
            "herramienta": newSession.herramienta,
            "evaluacion": newSession.evaluacion
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(.failure(err))
            } else {
                completion(.success("Documento agregado ID: \(ref!.documentID)"))
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

