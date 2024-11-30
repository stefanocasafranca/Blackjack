//
//  ViewController.swift
//  Blackjack
//
//  Created by Stefano Casafranca on 11/29/24.
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cardStackView: UIStackView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var askButton: UIButton!
    @IBOutlet weak var holdButton: UIButton!
    
    var game: BlackjackGame!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = BlackjackGame()
        startNewGame()
    }
    
    func startNewGame() {
        game.startGame()
        updateUI()
        askButton.isEnabled = true
        holdButton.isEnabled = true
        messageLabel.text = "Draw or Hold?"
    }
    
    func updateUI() {
        cardStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for card in game.playerHand {
            let cardView = UILabel()
            cardView.text = "\(card)"
            cardStackView.addArrangedSubview(cardView)
        }
        
        totalLabel.text = "Total: \(game.playerTotal)"
        
        if game.playerTotal > 21 {
            messageLabel.text = "Bust! You went over 21."
            endGame()
        } else if game.playerHand.count == 5 {
            messageLabel.text = "You win! You drew 5 cards without going over 21."
            endGame()
        }
    }
    
    func endGame() {
        askButton.isEnabled = false
        holdButton.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.startNewGame()
        }
    }
    
    @IBAction func askButtonTapped(_ sender: UIButton) {
        _ = game.drawCard()
        updateUI()
    }
    
    @IBAction func holdButtonTapped(_ sender: UIButton) {
        let nextCard = game.deck.last ?? 0
        let newTotal = game.playerTotal + nextCard
        
        if newTotal > 21 {
            messageLabel.text = "Win! Good call on holding, next card was going to be \(nextCard)."
        } else {
            messageLabel.text = "You lose! The next card (\(nextCard)) made a total of \(newTotal)."
        }
        
        updateUI()
        endGame()
    }
}
