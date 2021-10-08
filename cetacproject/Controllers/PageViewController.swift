//
//  PageViewController.swift
//  cetacproject
//
//  Created by user193544 on 9/28/21.
//  Copyright © 2021 CDT307. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    let pC = PagesMenuController(nibName: "PagesMenuController", bundle: nil)
    
    //var selectedOptionIndex: Int = 0
    //var currentTypeOfMenu : String = ""
    var screens:[UIViewController] = []
    
    lazy var orderedViewControllers: [UIViewController] = {
        
        
        //print(screens[selectedOptionIndex])
        return screens
    }()
    
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        
        if "ServiciosAcomp" == self.updateTypeOfMenu(){
                screens = [self.newVc(viewController: "Tanatologia"), self.newVc(viewController: "AcompIndividual"), self.newVc(viewController: "AcompGrupal"),self.newVc(viewController: "Logoterapia"),self.newVc(viewController: "Mindfulness")]
            }else if "ServiciosHolis" == self.updateTypeOfMenu(){
                screens = [self.newVc(viewController: "Aromaterapia"), self.newVc(viewController: "Cristaloterapia"), self.newVc(viewController: "Reiki"),self.newVc(viewController: "Biomagnetismo"),self.newVc(viewController: "Angeloterapia"),self.newVc(viewController: "CamaTermica")]
            }else if "QuienesSomos" == self.updateTypeOfMenu(){
                screens = [self.newVc(viewController: "Mision"), self.newVc(viewController: "Vision"), self.newVc(viewController: "Valores"),self.newVc(viewController: "Objetivos")]
            }else if "Objetivos" == self.updateTypeOfMenu(){
                screens = [self.newVc(viewController: "Objetivo1"), self.newVc(viewController: "Objetivo2"), self.newVc(viewController: "Objetivo3")]
            }else if "Alternativas" == self.updateTypeOfMenu(){
                screens = [self.newVc(viewController: "FloresBach"), self.newVc(viewController: "Brisas")]
                
            }
        
        super.viewDidLoad()

        self.dataSource = self
        
        setViewControllers([orderedViewControllers[self.updateIndex()]], direction: .forward, animated: true, completion: nil)
        self.delegate = self
        configurePageControl()
        self.updateVariables()
    }
    func updateIndex() -> Int {
        var selectedOptionIndex: Int = 0
        //set
        let path = Bundle.main.path(forResource: "selectedOptionIndex", ofType: "txt")
        let url = URL(fileURLWithPath: path!)
        
        //read
        let contentString = try! NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
        print(contentString)
        let msgString = contentString.components(separatedBy: ":").last!.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "}", with: "")
        print(msgString)
        selectedOptionIndex = Int(msgString) ?? 0
        
        return selectedOptionIndex
    }
    func updateTypeOfMenu() -> String {
        var currentTypeOfMenu: String = ""
        //set
        let path = Bundle.main.path(forResource: "typeOfMenu", ofType: "txt")
        let url = URL(fileURLWithPath: path!)
        
        //read
        let contentString = try! NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
        print(contentString)
        let msgString = contentString.components(separatedBy: ":").last!.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "}", with: "")
        print(msgString)
        currentTypeOfMenu = msgString
        
        return currentTypeOfMenu
    }
    func updateVariables(){
        //set
        let limpiaText = ""
        let path = Bundle.main.path(forResource: "typeOfMenu", ofType: "txt")
        let path2 = Bundle.main.path(forResource: "selectedOptionIndex", ofType: "txt")
        let url = URL(fileURLWithPath: path!)
        let url2 = URL(fileURLWithPath: path2!)
        //write
                do{
                    try limpiaText.write(to: url, atomically: true, encoding: String.Encoding.utf8)}
                catch{}
        do{
            try limpiaText.write(to: url2, atomically: true, encoding: String.Encoding.utf8)}
        catch{}
    }
    
    func configurePageControl(){
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY-150, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = self.updateIndex()
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    func newVc(viewController: String) -> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
        
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else{
            return nil
        }
        let previousIndex = viewControllerIndex-1
        
        guard previousIndex >= 0 else{
            //return orderedViewControllers.last
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else{
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else{
            return nil
        }
        let nextIndex = viewControllerIndex+1
        
        guard orderedViewControllers.count != nextIndex else{
            //return orderedViewControllers.first
            return nil
        }
        
        guard orderedViewControllers.count > nextIndex else{
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
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
