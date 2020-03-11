//
//  Card.swift
//  MemoryCardGame
//
//  Created by Max on 11/03/2020.
//  Copyright © 2020 chulkov. All rights reserved.
//

import Foundation

struct Card{
    
    var isFaceUp = false
    var isMatched = false
    var isMismatched = false
    var cardId: Int
    
    private static var cardIdFactory = 0
    
    private static func getUniqueId() -> Int{
        cardIdFactory += 1
        return cardIdFactory
    }
    
    init(){
        self.cardId = Card.getUniqueId()
    }
    
}
