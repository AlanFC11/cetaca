//
//  LoggedMenuViewController.swift
//  cetacproject
//
//  Created by user193544 on 10/6/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit
import SideMenu

class LoggedMenuViewController: UIViewController {

    var menu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    @IBAction func didTapMenu(){
        present(menu!, animated: true)
    }
    
    class MenuListController: UITableViewController{
        var items = ["Actualizar información", "Cerrar sesión"]
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
                screenStoryboardID = "Info"
                let storyboard = UIStoryboard(name: "Main", bundle: nil);
                let vc = storyboard.instantiateViewController(withIdentifier: screenStoryboardID) as! UIViewController;
                self.present(vc, animated: true, completion: nil);

            }
           
            
        }
        
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
