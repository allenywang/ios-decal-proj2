//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    var phrase: String = ""
    var correct: String = ""
    @IBOutlet var incorrectGuesses: UILabel!
    @IBOutlet var blanksFilledIn: UILabel!
    @IBAction func useGuess(_ sender: Any) {
        if (guessedLetter.text?.characters.count == 1) {
            if phrase.contains((guessedLetter.text?.capitalized)!) {
                blanksFilledIn.text = ""
                correct = correct + (guessedLetter.text?.capitalized)!
                var count = 0
                for char in phrase.characters {
                    if (correct.characters.contains(char)) {
                        blanksFilledIn.text = blanksFilledIn.text! + String(char) + " "
                        count = count + 1
                    } else {
                        if char == " " {
                            blanksFilledIn.text = blanksFilledIn.text! + "  "
                            count = count + 1
                        } else {
                            blanksFilledIn.text = blanksFilledIn.text! + "_ "
                        }
                        
                    }
                }
                if count == phrase.characters.count {
                    let alertController = UIAlertController(title: "WINNER", message:
                        "You WON", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Start Over", style: UIAlertActionStyle.default,handler: {action in self.viewDidLoad()}))
                    self.present(alertController, animated: true, completion: nil)
                }
            } else {
                incorrectGuesses.text = incorrectGuesses.text! + (guessedLetter.text?.capitalized)!
                hangmanImage.image = UIImage(named:String(format: "hangman%d.gif",((incorrectGuesses.text?.characters.count)! + 1)))
                if (incorrectGuesses.text?.characters.count)! >= 6 {
                    let alertController = UIAlertController(title: "LOSER", message:
                        "You Lost", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Start Over", style: UIAlertActionStyle.default,handler: {action in self.viewDidLoad()}))
                    self.present(alertController, animated: true, completion: nil)
                }

                
            }
        } else {
            let alertController = UIAlertController(title: "Warning", message:
                "Only use one character", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
        }
        guessedLetter.text = ""
        
    }
    @IBOutlet var guessedLetter: UITextField!
    @IBOutlet var hangmanImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        hangmanImage.image = UIImage(named:"hangman1.gif")
        blanksFilledIn.text = ""
        let count:Int = (phrase.characters.count)
        for char in phrase.characters {
            if char == " " {
                blanksFilledIn.text = blanksFilledIn.text! + "  "

            } else{
                blanksFilledIn.text = blanksFilledIn.text! + "_ "
            }
        }
        correct = ""
        incorrectGuesses.text = ""
        guessedLetter.text = ""
        

        print(phrase)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
