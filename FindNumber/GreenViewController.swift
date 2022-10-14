//
//  GreenViewController.swift
//  FindNumber
//
//  Created by Star Lord on 14/10/2022.
//

import UIKit

class GreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func GoToMenu(_ sender: Any) {
//        self.navigationController?.popToRootViewController(animated: true)
        
        if let viewController = self.navigationController?.viewControllers{
            for vc in viewController{
                if vc is YellowViewController{
                    self.navigationController?.popToViewController(vc, animated: false)
                }
            }
        }
            
    }
}
