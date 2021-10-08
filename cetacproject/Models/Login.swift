//
//  Login.swift
//  cetacproject
//
//  Created by user193544 on 10/5/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class Login{
    
    let db = Firestore.firestore()
    
    func updateName(id: String, name: String){
        db.collection("Cuentas").document(id).setData([ "nombre": name], merge: true)
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func updatePassword(id: String, password: String){
        db.collection("Cuentas").document(id).setData([ "password": password], merge: true)
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func login(mail:String, completion: @escaping (Result<CuentasInfo, Error>) -> Void){
        var cuentasInfo = [Cuentas]()
        db.collection("Cuentas").whereField("mail", isEqualTo: mail).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
              
                for document in querySnapshot!.documents {
                    var s = Cuentas(aDoc: document)
                    cuentasInfo.append(s)
                }
                completion(.success(cuentasInfo))
            }
        }
        /*
        cuentaValidar.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
 */
    }
    
    func fetchServicios(completion: @escaping (Result<CuentasInfo, Error>) -> Void){
        
//        let servicios = [Servicio(nombre: "Uno", desc: "Desc Uno")]
        var cuentasInfo = [Cuentas]()
        
        /*
        let usersCollection = db.collection("Usuario_Info")
        db.collection("Usuario_Info").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        */
        
        
        db.collection("Cuentas").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
              
                for document in querySnapshot!.documents {
                    var s = Cuentas(aDoc: document)
                    cuentasInfo.append(s)
                }
                completion(.success(cuentasInfo))
            }
        }
       
    }
    func fetchCuentas()-> [Cuentas]{
        var cuentasInfo = [Cuentas]()
        db.collection("Cuentas").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
              
                for document in querySnapshot!.documents {
                    var s = Cuentas(aDoc: document)
                    cuentasInfo.append(s)
                }
            }
        }
        return cuentasInfo
    }
    
}
