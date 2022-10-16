//
//  Game.swift
//  FindNumber
//
//  Created by Star Lord on 12/10/2022.
//

import Foundation

enum StatusGame{
    case Start
    case Win
    case lose
}



class Game{
    
    struct Item{
        var title : String
        
        var isFound : Bool = false
        
        var isError = false
    }
    
    private let data = Array(1...99)
    
    internal var items : [Item] = []
    
    private var countItems : Int
    private var timeForGame: Int
    private var secondsGame : Int{
        didSet{
            if secondsGame == 0{
                gameStatus = .lose
            }
            updateTimer(gameStatus, secondsGame)
        }
    }
    var isNewRecord = false
    var gameStatus: StatusGame = .Start{
        didSet{
            if gameStatus != .Start{
                
                let newRecord = timeForGame - secondsGame
                
                let record = UserDefaults.standard.integer(forKey: KeyUserDefaults.recordGame)
                
                if record == 0 || record > newRecord{
                    UserDefaults.standard.setValue(newRecord, forKey: KeyUserDefaults.recordGame)
                    isNewRecord = true
                }
                stopGame()
            }
        }
    }
    
    private var timer: Timer?
    
    var nextItem: Item?
    private var updateTimer: ((StatusGame, Int) -> ())
    
    init(countItem: Int, updateTimer: @escaping ( _ status: StatusGame, _ seconds: Int) -> Void){
        self.countItems = countItem
        self.timeForGame = Settings.shared.currentSettings.timeForGame
        self.secondsGame = self.timeForGame
        self.updateTimer = updateTimer
        setupGame()
    }
    
    private func setupGame(){
        isNewRecord = false
        var digits = data.shuffled()
        items.removeAll()
        while items.count < countItems{
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        
        updateTimer(gameStatus, secondsGame)
        
        if Settings.shared.currentSettings.timerState{
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self]( _ ) in
                self?.secondsGame -= 1
            } )
        }
        
        nextItem = items.shuffled().first
        
        
    }
    func check(index: Int){
        
        guard gameStatus == .Start else {return}
        if items[index].title == nextItem?.title{
            items[index].isFound = true
            
            nextItem = items.shuffled().first(where: { (item) -> Bool in item.isFound == false})
        } else {
            items[index].isError = true
        }
        if nextItem == nil{
            gameStatus = .Win
        }
    }
    func stopGame(){
        timer?.invalidate()
    }
    func newGame(){
        gameStatus = .Start
        self.secondsGame = self.timeForGame
        setupGame()
        
    }
}



extension Int{
    func secondsToString() -> String{
        let minutes = self / 60
        let seconds = self % 60
        
        return String(format: "%d:%02d", minutes, seconds)
    }
}
