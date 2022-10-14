//
//  YellowViewController.swift
//  FindNumber
//
//  Created by Star Lord on 14/10/2022.
//

import UIKit

class YellowViewController: UIViewController {
    
    @IBAction func GoToBlueController(_ sender: Any) {
        performSegue(withIdentifier: "GoToBlue", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("YellowViewController viewDidLoad")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("YellowViewController viewWillAppear")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("YellowViewController viewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("YellowViewController viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("YellowViewController viewDidDisappear")
    }
    deinit {
        print("Yellow ViewController Deinit")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "GoToBlue":
            if let blueVC = segue.destination as? BlueViewController{
                blueVC.textLabel = "Text String"
            }
        default: break
            
        }
    }
}
