//
//  UserTableViewController.swift
//  cetacproject
//
//  Created by user193544 on 10/8/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit
import Firebase

class UserTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var usersTableView: UITableView!
    
    var database = Login()
    var datos = [Cuentas]()

    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.dataSource = self
        usersTableView.delegate = self
        /*
        database.fetchServicios{ (result) in
            switch result{
            case .success(let cuentasInfo):self.updateUI(with: cuentasInfo)
            case .failure(let error):self.displayError(error, title: "No se pudo acceder a los servicios")
            }
            
        }
 */
        self.datos = database.fetchCuentas()
        usersTableView.reloadData()
        //bsuper.viewDidLoad()
        //print(datos[0].mail)
        
        

    }
    func updateUI(with cuentasInfo:CuentasInfo){
        DispatchQueue.main.async {
            self.datos = cuentasInfo
            print(self.datos[0])
            //self.tableView.reloadData()
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

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(self.datos.count)
        return self.datos.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)
        print("holaq")
        // Configure the cell...
        cell.textLabel?.text = datos[indexPath.row].nombre
        print("hola")
        print(datos[indexPath.row].nombre)
        cell.textLabel?.textColor = .black

        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
