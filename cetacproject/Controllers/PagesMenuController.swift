//
//  PagesMenuController.swift
//  cetacproject
//
//  Created by user193544 on 10/5/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit

class PagesMenuController: UIViewController {
    var option: String = ""
    var typeOfMenu : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var Mision: UIButton!
    @IBOutlet weak var Vision: UIButton!
    @IBOutlet weak var Valores: UIButton!
    @IBOutlet weak var Objetivos: UIButton!
    @IBOutlet weak var Objetivo1: UIButton!
    @IBOutlet weak var Objetivo2: UIButton!
    @IBOutlet weak var Objetivo3: UIButton!
    
    @IBOutlet weak var Tanatologia: UIButton!
    @IBOutlet weak var Mindfulness: UIButton!
    @IBOutlet weak var Logoterapia: UIButton!
    @IBOutlet weak var AcompGrupal: UIButton!
    @IBOutlet weak var AcompIndividual: UIButton!
    
    @IBOutlet weak var Aromaterapia: UIButton!
    @IBOutlet weak var Cristaloterapia: UIButton!
    @IBOutlet weak var Reiki: UIButton!
    @IBOutlet weak var Biomagnetismo: UIButton!
    @IBOutlet weak var Angeloterapia: UIButton!
    @IBOutlet weak var CamaTermica: UIButton!
    
    @IBOutlet weak var FloresBach: UIButton!
    @IBOutlet weak var Brisas: UIButton!
    
    @IBAction func h(_ sender: UIButton!) {
        
        if sender == Mision{
            option = "0"
            typeOfMenu = "QuienesSomos"
        }
        else if sender == Vision {
            option = "1"
            typeOfMenu = "QuienesSomos"
        }
        else if sender == Valores {
            option = "2"
            typeOfMenu = "QuienesSomos"
        }
        else if sender == Objetivos{
            option = "3"
            typeOfMenu = "QuienesSomos"
        }else if sender == Objetivo1{
            option = "0"
            typeOfMenu = "Objetivos"
        }else if sender == Objetivo2{
            option = "1"
            typeOfMenu = "Objetivos"
        }else if sender == Objetivo3{
            option = "2"
            typeOfMenu = "Objetivos"
        }
        else if sender == Tanatologia{
            option = "0"
            typeOfMenu = "ServiciosAcomp"
        }else if sender == AcompIndividual {
            option = "1"
            typeOfMenu = "ServiciosAcomp"
        }
        else if sender == AcompGrupal {
            option = "2"
            typeOfMenu = "ServiciosAcomp"
        }else if sender == Logoterapia {
            option = "3"
            typeOfMenu = "ServiciosAcomp"
        }else if sender == Mindfulness {
            option = "4"
            typeOfMenu = "ServiciosAcomp"
        }
        else if sender == Aromaterapia {
            option = "0"
            typeOfMenu = "ServiciosHolis"
        }else if sender == Cristaloterapia {
            option = "1"
            typeOfMenu = "ServiciosHolis"
        }else if sender == Reiki {
            option = "2"
            typeOfMenu = "ServiciosHolis"
        }else if sender == Biomagnetismo {
            option = "3"
            typeOfMenu = "ServiciosHolis"
        }else if sender == Angeloterapia {
            option = "4"
            typeOfMenu = "ServiciosHolis"
        }else if sender == CamaTermica {
            option = "5"
            typeOfMenu = "ServiciosHolis"
        }
        else if sender == FloresBach {
            option = "0"
            typeOfMenu = "Alternativas"
        }else if sender == Brisas {
            option = "1"
            typeOfMenu = "Alternativas"
        }
        
        
        //set
        let textTypeOfMenu = typeOfMenu
        let textOption = option
        let path = Bundle.main.path(forResource: "typeOfMenu", ofType: "txt")
        let url = URL(fileURLWithPath: path!)
        let path2 = Bundle.main.path(forResource: "selectedOptionIndex", ofType: "txt")
        let url2 = URL(fileURLWithPath: path2!)
        //write
        do{
            try textTypeOfMenu.write(to: url, atomically: true, encoding: String.Encoding.utf8)}
        catch{}
        //write
        do{
            try textOption.write(to: url2, atomically: true, encoding: String.Encoding.utf8)}
        catch{}
        
        
        let screenStoryboardID = "PageView"
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: screenStoryboardID) as! UIPageViewController;
        self.present(vc, animated: true, completion: nil);
        
    }
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var nextView = segue.destination as! PageViewController
        nextView.selectedOptionIndex = self.option
    }
    */

}
