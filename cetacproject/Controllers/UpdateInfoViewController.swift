//
//  UpdateInfoViewController.swift
//  cetacproject
//
//  Created by user193544 on 10/7/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit
import Firebase

class UpdateInfoViewController: UIViewController {
    let database = Login()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInfo()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var mail: UITextField!
    
    
    func setInfo(){
        let path = Bundle.main.path(forResource: "name", ofType: "txt")
        let url = URL(fileURLWithPath: path!)
        let path3 = Bundle.main.path(forResource: "mail", ofType: "txt")
        let url3 = URL(fileURLWithPath: path3!)
        
        let contentString = try! NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
        print(contentString)
        let msgString = contentString.components(separatedBy: ":").last!.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "}", with: "")
        print(msgString)
        name.text = msgString
        
        let contentString3 = try! NSString(contentsOf: url3, encoding: String.Encoding.utf8.rawValue)
        print(contentString3)
        let msgString3 = contentString3.components(separatedBy: ":").last!.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "}", with: "")
        print(msgString3)
        mail.text = msgString3
        
        password.text = ""
        newPassword.text = ""
        confirmPassword.text = ""
    }
    
    @IBAction func updateName(_ sender: Any!){
        let path1 = Bundle.main.path(forResource: "name", ofType: "txt")
        let url1 = URL(fileURLWithPath: path1!)
        let path = Bundle.main.path(forResource: "id", ofType: "txt")
        let url = URL(fileURLWithPath: path!)
        
        let contentString1 = try! NSString(contentsOf: url1, encoding: String.Encoding.utf8.rawValue)
        let nameString = contentString1.components(separatedBy: ":").last!.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "}", with: "")
        
        let contentString = try! NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
        let idString = contentString.components(separatedBy: ":").last!.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "}", with: "")
        
        //Call function database
        database.updateName(id: idString, name: self.name.text ?? "")
        do{
            try self.name.text?.write(to: url1, atomically: true, encoding: String.Encoding.utf8)}
        catch{}
        self.setInfo()
        self.createAlert(title: "Éxito", message: "El nombre se actualizó correctamente")
        
    }
    @IBAction func updatePassword(_ sender: Any!){
        let path2 = Bundle.main.path(forResource: "password", ofType: "txt")
        let url2 = URL(fileURLWithPath: path2!)
        let path = Bundle.main.path(forResource: "id", ofType: "txt")
        let url = URL(fileURLWithPath: path!)
        
        let contentString2 = try! NSString(contentsOf: url2, encoding: String.Encoding.utf8.rawValue)
        let passwordString = contentString2.components(separatedBy: ":").last!.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "}", with: "")
        let contentString = try! NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
        let idString = contentString.components(separatedBy: ":").last!.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "}", with: "")
        
        if  newPassword.text == confirmPassword.text && password.text == passwordString{
            //Call database
            database.updatePassword(id: idString, password: self.newPassword.text ?? "")
            do{
                try self.password.text?.write(to: url2, atomically: true, encoding: String.Encoding.utf8)}
            catch{}
            self.setInfo()
            self.createAlert(title: "Éxito", message: "La contraseña se actualizó correctamente")
        }else{
            self.createAlert(title: "Error", message: "Contraseña incorrecta")
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
