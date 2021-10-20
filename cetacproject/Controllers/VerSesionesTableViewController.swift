//
//  TanatTableViewController.swift
//  cetacproject
//
//  Created by user193544 on 10/13/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit
import Firebase

class VerSesionesTableViewController: UITableViewController {
    
    var datos = [Session]()
    let bd = Firestore.firestore()
    var userData = [String: String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "id", ofType: "txt")
        let url = URL(fileURLWithPath: path!)
        
        let string = try! NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
        let id = string.components(separatedBy: ":").last!.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "}", with: "")
        
        bd.collection("Sesion").whereField("IDtanatologo", isEqualTo: id).getDocuments(){ (QuerySnapshot, err) in
            if let err = err {
                print("Error en base de datos")
            } else {
                for document in QuerySnapshot!.documents{
                    var s = Session(aDoc: document)
                    self.datos.append(s)
                }
                self.bd.collection("UsuarioInfo").getDocuments(){ (QuerySnapshot, err) in
                    if let err = err {
                        print("error en usuarios")
                    } else {
                        for document in QuerySnapshot!.documents{
                            var s = Encuadre(aDoc: document)
                            self.userData[document.documentID] = s.name
                        }
                        self.tableView.reloadData()
                    }
                }
                
            }
        }
}

    
    func displayError(_ error: Error, title: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    
    // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return datos.count
        }

        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)

            // Configure the cell...
            let userID = datos[indexPath.row].IDUsuario
            let fecha = datos[indexPath.row].fecha
            let strin = self.userData[userID] ?? ""
            cell.textLabel?.text = strin + "  //  " + "Fecha: " + fecha
            print(strin + "  //  " + fecha)
            return cell
        }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView = segue.destination as! VerLaSesionViewController
        let indice = self.tableView.indexPathForSelectedRow?.row
        let userID = datos[indice!].IDUsuario
        nextView.name = self.userData[userID] ?? ""
        nextView.motive = datos[indice!].motivo
        nextView.service = datos[indice!].servicio
        nextView.intervention = datos[indice!].intervencion
        nextView.tool = datos[indice!].herramienta
        nextView.comment = datos[indice!].evaluacion
        nextView.cost = String(datos[indice!].cuota)
        nextView.iduser = datos[indice!].IDUsuario
        nextView.numSesion = String(datos[indice!].sesNum)
        if(datos[indice!].tipo == 1){
            nextView.typeSesion = "Primera"
        }else if (datos[indice!].tipo == 2){
            nextView.typeSesion = "Seguimiento"
        }else{
            nextView.typeSesion = "Cierre"
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
