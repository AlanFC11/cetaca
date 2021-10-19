//
//  TableTableViewController.swift
//  cetacproject
//
//  Created by user193544 on 10/8/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit
import Firebase

class SubAdminTableViewController: UITableViewController {
    
    var nameFilter: String = ""
    var idFilter: String = ""

    var servicioControlador = Login()
    var datos = [Cuentas]()
    var database = Login()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
       
        servicioControlador.fetchSubadmins{ (result) in
            switch result{
            case .success(let cuentasInfo):self.updateUI(with: cuentasInfo)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a los servicios")
            }
            
        }

        }
    func deleteSubAdmin(index: Int){
        self.database.deleteUser(id: datos[index].id)
        self.createAlert(title: "Éxito", message: "El subadmin se eliminó correctamente")
        
        
    }

    func updateUI(with cuentasInfo: CuentasInfo){
        DispatchQueue.main.async {
            if self.nameFilter != "" {
                self.datos = cuentasInfo.filter{$0.nombre == self.nameFilter}
                
            }else if self.idFilter != ""{
                self.datos = cuentasInfo.filter{$0.id == self.idFilter}
            }else{
                self.datos = cuentasInfo
            }
            self.tableView.reloadData()
            if self.datos.isEmpty{
                self.createSimpleAlert(title: "Sin resultados", message: "No se encontraron usuarios con el filtro seleccionado")
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
    func createSimpleAlert(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
    }
    func createAlert (title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        var viewControllerA: UIViewController?

        for  vc in (self.navigationController?.viewControllers ?? []) {
            if vc.isKind(of: SearchUsersViewController.self) {
                  viewControllerA = vc
                  break
            }
        }
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in self.navigationController?.popToViewController(viewControllerA ?? UIViewController(), animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func createAlertSubAdmin (title:String, message: String, index: Int){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cerrar", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        alert.addAction(UIAlertAction(title: "Borrar", style: UIAlertAction.Style.default, handler: {(action) in self.deleteSubAdmin(index: index)}))
        
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowNumber : Int = indexPath.row
        self.createAlertSubAdmin(title: "Subadmin", message: "Nombre:" + datos[rowNumber].nombre + "\n Email:" + datos[rowNumber].mail + "\n ID:" + datos[rowNumber].id, index: rowNumber)
       
        
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let siguiente = segue.destination as! EditInfoViewController
        let indice = self.tableView.indexPathForSelectedRow?.row
        siguiente.cuenta = datos[indice!]
    }
    
    */

}
