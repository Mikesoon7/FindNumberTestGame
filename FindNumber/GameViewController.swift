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
            if game.isNewRecord{
                showAlert()
            } else {
                showAlertActionSheet()
            }
        case .lose: MainInscription.text = "Don't give up. Try one more time"
            MainInscription.textColor = .red
            newGameButton.isHidden = false
            showAlertActionSheet()

        }
    }
    private func showAlert(){
        let alert = UIAlertController(title: "Congratulations", message: "U've reached new record", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)

        present(alert, animated: true)
    }
    private func showAlertActionSheet(){
        let alert = UIAlertController(title: "Whats's next", message: nil , preferredStyle: .actionSheet)
        let newGameAction = UIAlertAction(title: "Start new Game", style: .default) { [weak self] (_) in
            self?.game.newGame()
            self?.setupScreen()
        }
        let showRecord = UIAlertAction(title: "Show record", style: .default){ [weak self] (_) in
            
            self?.performSegue(withIdentifier: "recordVC", sender: nil)

        }
        let menuAction = UIAlertAction(title: "Go to Menu", style: .default){ [weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default )
        
        alert.addAction(newGameAction)
        alert.addAction(showRecord)
        alert.addAction(menuAction)
        alert.addAction(cancelAction)
        
        if let popover = alert.popoverPresentationController{
            popover.sourceView = NumberOf
//            popover.sourceRect = CGRect(x: self.view.bounds.maxX , y: self.view.bounds.midY, width: 0, height: 0)
//            popover.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
        }
        present(alert, animated: true, completion: nil)

    }
}
