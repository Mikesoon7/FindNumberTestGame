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
}



class Game{
    
    struct Item{
        var title : String
        
        var isFound : Bool = false
    }
    
    private let data = Array(1...99)
    
    internal var items : [Item] = []
    
    private var countItems : Int
    
    var gameStatus: StatusGame = .Start
    
    var nextItem: Item?
    init(countItem: Int){
        self.countItems = countItem
        setupGame()
    }
    
    private func setupGame(){
        var digits = data.shuffled()
        
        while items.count < countItems{
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        
        nextItem = items.shuffled().first
    }
    func check(index: Int){
        if items[index].title == nextItem?.title{
            items[index].isFound = true
            
            nextItem = items.shuffled().first(where: { (item) -> Bool in item.isFound == false})
        }
        if nextItem == nil{
            gameStatus = .Win
        }
    }
}
