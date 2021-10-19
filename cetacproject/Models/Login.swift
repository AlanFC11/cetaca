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
    
    
    func updateEncuadre(id: String, ocupacion: String, religion: String, procedencia: String, domicilio: String,
                        telefono: String, sexo: String, edad: Int, estadoCivil: String, celular: String){
        db.collection("UsuarioInfo").document(id).setData(["trabajo": ocupacion, "religion": religion, "edad": edad, "procedencia": procedencia,
                                                           "estado civil": estadoCivil, "sexo": sexo, "telefono casa": telefono, "telefono celular": celular, "domicilio": domicilio], merge: true)
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func updateName(id: String, name: String) -> Int{
        var status: Int = 1
        db.collection("Cuentas").document(id).setData([ "nombre": name], merge: true)
        { err in
            if let err = err {
                print("Error writing document: \(err)")
                status = 0
            } else {
                status = 1
                print("Document successfully written!")
            }
        }
        return status
    }
    
    func updatePassword(id: String, password: String) -> Int{
        var status: Int = 1
        db.collection("Cuentas").document(id).setData([ "password": password], merge: true)
        { err in
            if let err = err {
                print("Error writing document: \(err)")
                status = 0
            } else {
                print("Document successfully written!")
                status = 1
            }
        }
        return status
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
    }
    func deleteUser(id: String) -> Int{
        var status:Int = 1
        db.collection("Cuentas").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
                status = 0
            } else {
                print("Document successfully removed!")
                status = 1
            }
        }
        return status

    }
    func fetchSubadmins(completion: @escaping (Result<CuentasInfo, Error>) -> Void){

        var cuentasInfo = [Cuentas]()
        
        db.collection("Cuentas").whereField("permisos", isEqualTo: 2) .getDocuments(){ (querySnapshot, err) in
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
    func fetchTanats(completion: @escaping (Result<CuentasInfo, Error>) -> Void){

        var cuentasInfo = [Cuentas]()
        
        db.collection("Cuentas").whereField("permisos", isEqualTo: 1) .getDocuments(){ (querySnapshot, err) in
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
    func fetchUsers(completion: @escaping (Result<LoginInfos, Error>) -> Void){

        var loginInfos = [LoginInfo]()
        
        db.collection("UsuarioInfo").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
              
                for document in querySnapshot!.documents {
                    var s = LoginInfo(aDoc: document)
                    loginInfos.append(s)
                }
                completion(.success(loginInfos))
            }
        }
       
    }
    func fetchSessions(completion: @escaping (Result<Sesiones, Error>) -> Void){

        var sesiones = [Sesion]()
        
        db.collection("Sesion").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
              
                for document in querySnapshot!.documents {
                    var s = Sesion(aDoc: document)
                    sesiones.append(s)
                }
                completion(.success(sesiones))
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
