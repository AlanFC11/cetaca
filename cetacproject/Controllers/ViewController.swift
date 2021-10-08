//
//  ViewController.swift
//  cetacproject
//
//  Created by CDT307 on 03/09/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeScreen(){
     let screenStoryboardID = "navBarServiciosMenu"
     let storyboard = UIStoryboard(name: "Main", bundle: nil);
     let vc = storyboard.instantiateViewController(withIdentifier: screenStoryboardID) as! UINavigationController;
     self.present(vc, animated: true, completion: nil);
        
        
    }
 

}


