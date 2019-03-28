//
//  Concentration.swift
//  Concentration
//
//  Created by Stanley Cheah on 3/5/19.
//  Copyright © 2019 Stanley Cheah. All rights reserved.
//

// Access Control
// internal - this is the default, it means "usable by any object in my app or framework
// private - this means "only callable from within this object"
// private(set) - this means "this property is readable outside this object, but not settable"
// fileprivate - accessible by any code in this source file
// public - (for frameworks only) this can be used by objects outside my framework
// open - (for frameworks only) public and objects outside my framework can subclass this

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                // indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
//                for flipDownIndex in cards.indices {
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
        for index in 0..<cards.count {
            cards[index].isFaceUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        shuffleCards()
    }
    
    func shuffleCards() {
        for cardIndex in cards.indices {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            
            let tempCard = cards[cardIndex]
            cards[cardIndex] = cards[randomIndex]
            cards[randomIndex] = tempCard
        }
    }
}
