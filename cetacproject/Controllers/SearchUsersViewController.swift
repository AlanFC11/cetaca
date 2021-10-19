//
//  SearchUsersViewController.swift
//  cetacproject
//
//  Created by user193544 on 10/14/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit

class SearchUsersViewController: UIViewController {
    
    var nameFilterUser: String?
    var idFilterUser: String?
    var nameFilterSubAdmin: String?
    var idFilterSubAdmin: String?
    var nameFilterTanat: String?
    var idFilterTanat: String?

    @IBOutlet weak var nameTanat: UITextField!
    @IBOutlet weak var idTanat: UITextField!
    @IBOutlet weak var nameSubAdmin: UITextField!
    @IBOutlet weak var idSubAdmin: UITextField!
    @IBOutlet weak var nameUser: UITextField!
    @IBOutlet weak var idUser: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func filterByNameUser(){
        self.nameFilterUser = nameUser.text
        self.idFilterUser = ""
    }
    
    @IBAction func filterByIDUser(){
        self.idFilterUser = idUser.text
        self.nameFilterUser = ""
    }
    
    @IBAction func showAllUser(){
        self.idFilterUser = ""
        self.nameFilterUser = ""
    }
    @IBAction func filterByNameTanat(){
        self.nameFilterTanat = nameTanat.text
        self.idFilterTanat = ""
    }
    
    @IBAction func filterByIDTanat(){
        self.idFilterTanat = idTanat.text
        self.nameFilterTanat = ""
    }
    
    @IBAction func showAllTanat(){
        self.idFilterTanat = ""
        self.nameFilterTanat = ""
    }
    @IBAction func filterByNameSubAdmin(){
        self.nameFilterSubAdmin = nameSubAdmin.text
        self.idFilterSubAdmin = ""
    }
    
    @IBAction func filterByIDSubAdmin(){
        self.idFilterSubAdmin = idSubAdmin.text
        self.nameFilterSubAdmin = ""
    }
    
    @IBAction func showAllSubAdmin(){
        self.idFilterSubAdmin = ""
        self.nameFilterSubAdmin = ""
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let siguiente = segue.destination as? UserTableViewController{
            siguiente.nameFilter = self.nameFilterUser ?? ""
            siguiente.idFilter = self.idFilterUser ?? ""
        }
        else if let s = segue.destination as? SubAdminTableViewController{
            s.nameFilter = self.nameFilterSubAdmin ?? ""
            s.idFilter = self.idFilterSubAdmin ?? ""
        }
        else if let ss = segue.destination as? TanatTableViewController{
            ss.nameFilter = self.nameFilterTanat ?? ""
            ss.idFilter = self.idFilterTanat ?? ""
        }
    }
    

}
