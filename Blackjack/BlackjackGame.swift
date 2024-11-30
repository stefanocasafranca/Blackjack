//
//  BlackjackGame.swift
//  Blackjack
//
//  Created by Stefano Casafranca on 11/29/24.
//

import Foundation

class BlackjackGame {
    var deck: [Int] = []
    var playerHand: [Int] = []
    var playerTotal: Int {
        return playerHand.reduce(0, +)
    }
    
    init() {
        resetDeck()
    }
    
    func resetDeck() {
        deck = Array(1...10).flatMap { Array(repeating: $0, count: 4) }
        deck.shuffle()
    }
    
    func drawCard() -> Int {
        guard let card = deck.popLast() else { return 0 }
        playerHand.append(card)
        return card
    }
    
    func startGame() {
        resetDeck()
        playerHand = []
        _ = drawCard()  // Draw first card
        _ = drawCard()  // Draw second card
    }
}
