//
//  ViewController.swift
//  MemoryCardGame
//
//  Created by Max on 11/03/2020.
//  Copyright © 2020 chulkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Game(numberOfPairOfCards: numberOfPairOfCards)
    
    var numberOfPairOfCards: Int {
        return (cardButtons.count + 1) / 2
    }

    weak var timer: Timer?
    var startTime: Double = 0
    var currentTime: Double = 0
    var cardFirstTouch = true
    private let userDefault = UserDefaults.standard
    
    
    @IBOutlet weak var bestTimeLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    let emojiThemes = ["Halloween": ["🧟‍♀️", "🧛🏻‍♂️", "🤡", "😈", "🎃", "🎁", "🙀", "🧠"],
                       "Nature": ["🌚", "🌈", "❄️", "☘️", "🍎", "🌻", "🌵", "🍌"],
                       "Faces": ["🤪", "😭", "🥵", "🤬", "🤮", "🤠", "🤒", "🥶"],
                       "People": ["👮🏻‍♂️", "👨🏻‍🌾", "👨🏻‍🔬", "👨🏻‍🏫", "👩🏻‍🚒", "👨🏻‍🚀", "👨🏻‍🍳", "👩🏼‍🎓"],
                       "Animals": ["🦖", "🐻", "🦞", "🦆", "🐒", "🐛", "🐝", "🐙"]]
    
    let backgroundThemes = ["Halloween": #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
                            "Nature": #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1),
                            "Faces": #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),
                            "People": #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),
                            "Animals": #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
        
        bestTimeLabel.text = String(format: "%.2f", userDefault.double(forKey: "bestTime"))
        
        
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if cardFirstTouch{
            startTimer()
            cardFirstTouch = false
        }
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        
    }
    fileprivate func newGame() {
        stopTimer()
        cardFirstTouch = true
        game = Game(numberOfPairOfCards: numberOfPairOfCards)
        let themeChooser = emojiThemes.randomElement()!
        emojiChoices = themeChooser.value
        updateViewFromModel()
        view.backgroundColor = backgroundThemes[themeChooser.key]
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        
        newGame()
    }
    
    
    
    
    func startTimer(){
        startTime = Date().timeIntervalSinceReferenceDate
        timer = Timer.scheduledTimer(timeInterval: 0.05,
                                     target: self,
                                     selector: #selector(advanceTimer(timer:)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    //When the view controller is about to disappear, invalidate the timer
    func stopTimer(){
        timer?.invalidate()
        
    }
    
    
    @objc func advanceTimer(timer: Timer) {
        //Total time since timer started, in seconds
        currentTime = Date().timeIntervalSinceReferenceDate - startTime
        let timeString = String(format: "%.2f", currentTime)
        timerLabel.text = timeString
    }
    
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
            }else{
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            }
        }
        if game.gameOver{
            gameOver()
        }
    }
    
    fileprivate func showAlert() {
        let alert = UIAlertController(title: "Game Over", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "New Game", style: .default, handler: { action in
            self.newGame()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func gameOver(){
        print("GameOver - \(String(format: "%.2f", currentTime))")
        stopTimer()
        updateBestTime()
        showAlert()
    }
    
    func updateBestTime(){
        let bestTime = userDefault.double(forKey: "bestTime")
        if bestTime == 0.0{
            userDefault.set(currentTime, forKey: "bestTime")
            bestTimeLabel.text = String(format: "%.2f", currentTime)
        }else if bestTime > currentTime{
            userDefault.set(currentTime, forKey: "bestTime")
            bestTimeLabel.text = String(format: "%.2f", currentTime)
        }
        
    }
    
    private lazy var emojiChoices = emojiThemes.randomElement()!.value
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.cardId] == nil, emojiChoices.count > 0{
            emoji[card.cardId] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.cardId] ?? "?"
    }
    
}

extension Int {
    var arc4random: Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(self)))
        }else{
            return 0
        }
        
    }
}


