//
//  ViewController.swift
//  Kalla_WordGuess
//
//  Created by Kalla,Muralidhar Reddy on 3/30/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var wordsGuessedLabel: UILabel!
    
    @IBOutlet weak var wordsMissedLabel: UILabel!

    @IBOutlet weak var wordsRemainingLabel: UILabel!
    
    @IBOutlet weak var totalWordsLabel: UILabel!
    
    @IBOutlet weak var userGuessLabel: UILabel!
    
    @IBOutlet weak var guessLetterField: UITextField!
    
    @IBOutlet weak var guessLetterButton: UIButton!
    
    @IBOutlet weak var hintLabel: UILabel!
    
    @IBOutlet weak var guessCountLabel: UILabel!
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var wordsToGuess = [["CRICKET","Name of a game"],
                            ["LION","An Animal"],["EARTH","A Planet"],["IPHONE","An apple product"],["AUDI","A luxury car"]]
    
    var hint = ""
    var images = ["cricket","lion","earth","iphone","audi","try"]
    var wordToGuess = ""
    var wordToGuessIndex = 0
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 10
    var wrongGuessesRemaining = 10
    var guessCount = 0
    var wordsGuessedCount = 0
    var wordsMissedCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordToGuess = wordsToGuess[wordToGuessIndex][0]
                hint = wordsToGuess[wordToGuessIndex][1]
                hintLabel.text = "HINT: " + hint
                
                totalWordsLabel.text = "Total number of words in game: \(wordsToGuess.count)"
                wordsRemainingLabel.text = "Total number of words remaining in game:\(wordsToGuess.count)"
                formatUserGuessLabel()
        
                guessLetterButton.isEnabled = false
                
                playAgainButton.isHidden = true
            }

           
            
            func updateWordCountLabels(){
                
                wordsMissedLabel.text = "Total number of words guessed wrongly: \(wordsMissedCount)"
                wordsGuessedLabel.text = "Total number of words Guessed successfully: \(wordsGuessedCount)"
                
                wordsRemainingLabel.text = "Total number of words remaining in game:\(wordsToGuess.count - (wordsGuessedCount + wordsMissedCount))"
            }
            
            func updateUIAfterGuess(){
                
                guessLetterField.resignFirstResponder()
                
                guessLetterField.text = ""
            }
            
            func formatUserGuessLabel() {
                var revealedWord = ""
                lettersGuessed += guessLetterField.text!
                
                for letter in wordToGuess {
                    if lettersGuessed.contains(letter) {
                        revealedWord = revealedWord + " \(letter)"
                    } else {
                        revealedWord += " _"
                    }
                }
                revealedWord.removeFirst()
                userGuessLabel.text = revealedWord
            }
            
            
            
            func guessALetter() {
                formatUserGuessLabel()
                guessCount += 1
                
                
                let currentLetterGuessed = guessLetterField.text!
                
                if !wordToGuess.contains(currentLetterGuessed) {
                    
                    wrongGuessesRemaining = wrongGuessesRemaining - 1
                    
                }
                
                let revealedWord = userGuessLabel.text!
                
                if wrongGuessesRemaining == 0 {
                    
                    playAgainButton.isHidden = false
                    guessLetterField.isEnabled = false
                    guessLetterButton.isEnabled = false
                    
                    guessCountLabel.text = "You have used all the available guesses, Please start again?"
                    wordsMissedCount += 1
                    updateWordCountLabels()
                    updateTryImageView()
                    
                } else if !revealedWord.contains("_") {
                   
                    playAgainButton.isHidden = false
                    guessLetterField.isEnabled = false
                    guessLetterButton.isEnabled = false
                    guessCountLabel.text = "You won! It took you \(guessCount) attempts to guess the word!"
                    wordsGuessedCount += 1
                    updateWordCountLabels()
                    updateImageView()
                } else {
                    // Update our guess count
                    let guess = ( guessCount == 1 ? "Guess" : "Guesses")
                    guessCountLabel.text = "You have made \(guessCount) \(guess)"
                }
                
                if (wordsGuessedCount + wordsMissedCount) == wordsToGuess.count {
                    guessCountLabel.text = "Congratulations, You are done, Please start over again"
                    updateImageView()
                }
            }
        
    

    @IBAction func guessLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessLetterField.text?.last {
                    guessLetterField.text = "\(letterGuessed)"
                    guessLetterButton.isEnabled = true
                } else {
                    
                    guessLetterButton.isEnabled = false
                }
    }
    
    
    
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
                updateUIAfterGuess()
                let letter = guessLetterField.text
                if letter?.isEmpty == true{
                    guessLetterButton.isEnabled = false
                }
                else{
                    guessLetterButton.isEnabled = true
                }
    }
    
    
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
                updateUIAfterGuess()
                let letter = guessLetterField.text
                if letter?.isEmpty == true{
                    guessLetterButton.isEnabled = false
                }
                else{
                    guessLetterButton.isEnabled = true
                }
    
    }
    
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        imageView.isHidden = true
                wordToGuessIndex += 1
                if wordToGuessIndex == wordsToGuess.count {
                    wordToGuessIndex = 0
                    wordsGuessedCount = 0
                    wordsMissedCount = 0
                    updateWordCountLabels()
                }
                wordToGuess = wordsToGuess[wordToGuessIndex][0]
                hint = wordsToGuess[wordToGuessIndex][1]
                hintLabel.text = "HINT: " + hint
                
                playAgainButton.isHidden = true
                guessLetterField.isEnabled = true
                guessLetterButton.isEnabled = false
                
                wrongGuessesRemaining = maxNumberOfWrongGuesses
                lettersGuessed = ""
                formatUserGuessLabel()
                guessCountLabel.text = "You've Made 0 Guesses"
                guessCount = 0
            }
    
    
    func updateTryImageView(){
                        
                            imageView.isHidden = false
                            imageView.image = UIImage(named: images[5])
        animateImage();
                    }
                        
    func updateImageView(){
        
        imageView.isHidden = false
        imageView.image = UIImage(named: images[wordToGuessIndex])
        animateImage()
        }
        
        func animateImage(){
            let originalImageFrame = imageView.frame
            let widthShrink: CGFloat = 10
            let heightShrink: CGFloat = 10
            let newFrame = CGRect(
            x: imageView.frame.origin.x + widthShrink,
            y: imageView.frame.origin.y + heightShrink,
            width: imageView.frame.width - widthShrink,
            height: imageView.frame.height - heightShrink)
            imageView.frame = newFrame
            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10.0,  animations: {
                self.imageView.frame = originalImageFrame
            })
        }
                        
        
    
}

