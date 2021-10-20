//
//  MainMenuViewController.swift
//  cetacproject
//
//  Created by CDT307 on 03/09/21.
//  Copyright © 2021 CDT307. All rights reserved.
//
import SideMenu
import UIKit
import Firebase

class MainMenuViewController: UIViewController, UITextFieldDelegate{
    
    @IBAction func hideKeyboard(_ sender: UITapGestureRecognizer) {
        TxtFieldPassword.resignFirstResponder()
        TxtFieldEmail.resignFirstResponder()
    }
    
    @IBOutlet weak var TxtFieldEmail: UITextField!
    @IBOutlet weak var TxtFieldPassword: UITextField!
    var database = Login()
    var datos = [Cuentas]()

    var menu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (TxtFieldPassword != nil && TxtFieldEmail != nil){
            TxtFieldEmail.delegate = self
            TxtFieldPassword.delegate = self
        }
        
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    @IBAction func didTapMenu(){
        present(menu!, animated: true)
    }
    
    @IBAction func login(){
        database.login(mail: (self.TxtFieldEmail.text)!){ (result) in
            switch result{
            case .success(let cuentasInfo):self.letLogin(with: cuentasInfo)
            case .failure(let error):self.displayError(error, title: "Error del servidor")
            }
            
        }
        
    }
    func letLogin(with cuentasInfo:CuentasInfo){
        DispatchQueue.main.async {
            self.datos = cuentasInfo
            if cuentasInfo.count != 0 && (self.datos[0].password == self.TxtFieldPassword.text) {
                var screenStoryboardID : String = ""
                let storyboardLogged = UIStoryboard(name: "Main", bundle: nil);
                if self.datos[0].permisos == 1{
                    screenStoryboardID = "navBarTanMenu"
                    
                }else if self.datos[0].permisos == 2{
                    screenStoryboardID = "navBarSubAdminMenu"
                }else{
                    screenStoryboardID = "navBarAdminMenu"
                }
                let vc = storyboardLogged.instantiateViewController(withIdentifier: screenStoryboardID) as! UINavigationController;
                self.present(vc, animated: true, completion: nil);
                
                
                let path = Bundle.main.path(forResource: "name", ofType: "txt")
                let url = URL(fileURLWithPath: path!)
                let path2 = Bundle.main.path(forResource: "password", ofType: "txt")
                let url2 = URL(fileURLWithPath: path2!)
                let path3 = Bundle.main.path(forResource: "mail", ofType: "txt")
                let url3 = URL(fileURLWithPath: path3!)
                let path4 = Bundle.main.path(forResource: "id", ofType: "txt")
                let url4 = URL(fileURLWithPath: path4!)
                //write
                do{
                    try self.datos[0].nombre.write(to: url, atomically: true, encoding: String.Encoding.utf8)}
                catch{}
                do{
                    try self.datos[0].password.write(to: url2, atomically: true, encoding: String.Encoding.utf8)}
                catch{}
                do{
                    try self.datos[0].mail.write(to: url3, atomically: true, encoding: String.Encoding.utf8)}
                catch{}
                do{
                    try self.datos[0].id.write(to: url4, atomically: true, encoding: String.Encoding.utf8)}
                catch{}
                
            }else{
                self.createAlert(title: "Error", message: "Usuario y/o contraseña incorrecto")
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
    
    func createAlert (title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
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
class MenuListController: UITableViewController{
    var items = ["Servicios","Iniciar sesión"]
    let menuColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = menuColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = menuColor
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowNumber : Int = indexPath.row
        let screenStoryboardID : String
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        if rowNumber == 1 {
            screenStoryboardID = "navBarLoginScreen"
        
            let vc = storyboard.instantiateViewController(withIdentifier: screenStoryboardID) as! UINavigationController;
            //let vc = storyboard.instantiateViewController(withIdentifier: screenStoryboardID) as! UIViewController;
            self.present(vc, animated: true, completion: nil);
            
        }
        else{
            screenStoryboardID = "navBarServiciosMenu"
            let storyboard = UIStoryboard(name: "Main", bundle: nil);
            let vc = storyboard.instantiateViewController(withIdentifier: screenStoryboardID) as! UINavigationController;
            self.present(vc, animated: true, completion: nil);

        }
       
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
