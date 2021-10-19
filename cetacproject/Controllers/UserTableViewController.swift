//
//  UserTableViewController.swift
//  cetacproject
//
//  Created by user193544 on 10/8/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit
import Firebase

class UserTableViewController: UITableViewController{
    
    var nameFilter:String = ""
    var idFilter: String = ""
    
    var servicioControlador = Login()
    var datos = [LoginInfo]()
    var database = Login()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
       
        servicioControlador.fetchUsers{ (result) in
            switch result{
            case .success(let loginInfos):self.updateUI(with: loginInfos)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a los usuarios")
            }
            
        }

        }
    
    func updateUI(with loginInfos: LoginInfos){
        DispatchQueue.main.async {
            if self.nameFilter != "" {
                self.datos = loginInfos.filter{$0.nombre == self.nameFilter}
                
            }else if self.idFilter != ""{
                self.datos = loginInfos.filter{$0.id == self.idFilter}
            }else{
                self.datos = loginInfos
            }
            self.tableView.reloadData()
            if self.datos.isEmpty{
                self.createAlert(title: "Sin resultados", message: "No se encontraron usuarios con el filtro seleccionado")
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
    func createAlert(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
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
            cell.textLabel?.text = datos[indexPath.row].nombre
    

            return cell
        }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         let siguiente = segue.destination as! EncuadreUpdateInfoViewController
         let indice = self.tableView.indexPathForSelectedRow?.row
         siguiente.user = datos[indice!]
     }
    

}
extension Array where Element: Equatable {
    func all(where predicate: (Element) -> Bool) -> [Element]  {
        return self.compactMap { predicate($0) ? $0 : nil }
    }
}
