//
//  GameViewController.swift
//  FindNumber
//
//  Created by Star Lord on 11/10/2022.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var NumberOf: UILabel!
    
    @IBOutlet weak var NextDigit: UILabel!
    
    lazy var game = Game(countItem: buttons.count)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        
    }
    @IBAction func pressButton(_ sender: UIButton){
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index:buttonIndex)
        sender.tintColor = .black
        
        NumberOf.text = sender.title(for: sender.state)
        
        updateUi()
    }
    
    internal func setupScreen(){
        
        for index in game.items.indices{
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].isHidden = false
        }
        
        NextDigit.text = game.nextItem?.title
    }
    private func updateUi(){
        for index in game.items.indices{
            buttons[index].isHidden = game.items[index].isFound
            
        }
        NextDigit.text = game.nextItem?.title
    }
    
}
