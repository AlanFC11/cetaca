//
//  FiltroReportesViewController.swift
//  cetacproject
//
//  Created by user193544 on 10/18/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit

class FiltroReportesViewController: UIViewController {
    
    var typeOfChart = ""
    
    @IBAction func CuotaGlobalChart(_ sender: Any) {
        typeOfChart = "CuotaGlobal"
    }
    
    @IBAction func IntervencionesChart(_ sender: Any) {
        typeOfChart = "Intervenciones"
    }
    @IBAction func ServiciosChart(_ sender: Any) {
        typeOfChart = "Servicios"
    }
    @IBAction func CuotaTanatChart(_ sender: Any) {
        typeOfChart = "CuotaTanat"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguiente = segue.destination as! ChartsViewController
        siguiente.typeOfChart = typeOfChart
    }
    

}
