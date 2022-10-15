//
//  GameViewController.swift
//  FindNumber
//
//  Created by Star Lord on 11/10/2022.
//

import UIKit

class GameViewController: UIViewController {
    

    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var MainInscription: UILabel!
    @IBOutlet weak var NumberOf: UILabel!
    
    @IBOutlet weak var NextDigit: UILabel!
    
    lazy var game = Game(countItem: buttons.count, updateTimer: { [weak self](gameStatus, time) in
        
        guard let self = self else {return}
        self.TimeLabel.text = time.secondsToString()
        self.updateInfoGame(with: gameStatus)
        
    })

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        game.stopGame()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        
        NumberOf.text = "Which number it'll be?"
        
    }
    @IBOutlet weak var TimeLabel: UILabel!
    @IBAction func pressButton(_ sender: UIButton){
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index:buttonIndex)
        
        NumberOf.text = sender.title(for: sender.state)
        
        updateUi()
    }
    
    @IBAction func NewGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
        
    }
    internal func setupScreen(){
        
        for index in game.items.indices{
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].alpha = 1
            buttons[index].isEnabled = true

        }
        NextDigit.text = game.nextItem?.title
    }
    private func updateUi(){
        for index in game.items.indices{
//            buttons[index].isHidden = game.items[index].isFound
            buttons[index].alpha = game.items[index].isFound ? 0 : 1
            buttons[index].isEnabled = !game.items[index].isFound
            if game.items[index].isError{
                UIView.animate(withDuration: 1) { [weak self] in
                    self?.buttons[index].tintColor = .red
                } completion: { [weak self](_) in
                    self?.buttons[index].tintColor = .systemBlue
                    self?.game.items[index].isError = false
                }
            }
        }
        NextDigit.text = game.nextItem?.title
        
        updateInfoGame(with: game.gameStatus)
    }
    
    private func updateInfoGame(with status: StatusGame){
        switch status{
        case .Start: MainInscription.text = "Game Started"
            newGameButton.isHidden = true
        case .Win: MainInscription.text = "Congratulations"
            MainInscription.textColor = .green
            newGameButton.isHidden = false
        case .lose: MainInscription.text = "Don't give up. Try one more time"
            MainInscription.textColor = .red
            newGameButton.isHidden = false

        }
    }
}
