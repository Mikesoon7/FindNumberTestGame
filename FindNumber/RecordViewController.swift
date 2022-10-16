//
//  RecordViewController.swift
//  FindNumber
//
//  Created by Star Lord on 15/10/2022.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet weak var recordLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let record = UserDefaults.standard.integer(forKey: KeyUserDefaults.recordGame)
        if record != 0{
            recordLabel.text = "Your record is \(record) seconds"
            
        } else {
            recordLabel.text = "There is no record"
        }
    }
    
}
