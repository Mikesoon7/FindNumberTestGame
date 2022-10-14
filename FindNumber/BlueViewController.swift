//
//  BlueViewController.swift
//  FindNumber
//
//  Created by Star Lord on 14/10/2022.
//

import UIKit

class BlueViewController: UIViewController {

    var textLabel = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        TestLabel.text = textLabel

        
    }
    @IBOutlet weak var TestLabel: UILabel!
    
    @IBAction func goToGreenController(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "greenVC")
        vc.title = "Green"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
