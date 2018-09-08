//
//  ResultViewController.swift
//  Roshambo - Udacity
//
//  Created by Vigneshraj Sekar Babu on 8/19/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

public let imageArray = ["rock","paper","scissors"]

class ResultViewController: UIViewController {
    
    //Properties
    var userSelection: Selection?
    var computerSelection: Selection?
    
    //Outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var computerImageView: UIImageView!
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    //constraints
    @IBOutlet weak var viewTopToSelectionStack: NSLayoutConstraint!
    @IBOutlet weak var selectionStackToResult: NSLayoutConstraint!
    @IBOutlet weak var resultImagetoText: NSLayoutConstraint!
    @IBOutlet weak var resultTextToPlayAgain: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        computerSelect()
        displaySelectionFromPlayers()
        determineResult()
    }
    
    //MARK: - Computer's turn
    func computerSelect() {
        var random :  Int = 0
        random = Int(arc4random_uniform(500))
        computerSelection = Selection(rawValue: random % 3)
    }
    
    func displaySelectionFromPlayers() {
        guard let userSelection = userSelection else { fatalError("User selection missing")}
        guard let computerSelection = computerSelection else { fatalError("Computer selection missing")}
        userImageView.image = UIImage(named: imageArray[userSelection.rawValue])
        computerImageView.image = UIImage(named: imageArray[computerSelection.rawValue])
    }
    
    //MARK: - Game Logic
    func determineResult() {
        guard let userChoice = userSelection else { fatalError("User selection missing")}
        guard let computerChoice = computerSelection else { fatalError("Computer selection missing")}
        var result: Result = .None
        
        if userChoice == Selection.rock {
            switch computerChoice {
            case .rock:
                tie()
                result = .Tie
            case .paper:
                resultLabel.text = "Paper covers Rock! You Lose!!"
                resultImageView.image = UIImage(named: "PaperCoversRock")
                result = .Lose
            case .scissor:
                resultLabel.text = "Rock crushes scissors! You Win!!"
                resultImageView.image = UIImage(named: "RockCrushesScissors")
                result = .Win
            }
        } else  if userChoice == Selection.paper {
            switch computerChoice {
            case .rock:
                resultLabel.text = "Paper covers Rock! You Win!!"
                resultImageView.image = UIImage(named: "PaperCoversRock")
                result = .Win
            case .paper:
                tie()
                result = .Tie
            case .scissor:
                resultLabel.text = "Scissor cuts Paper! You Lose!!"
                resultImageView.image = UIImage(named: "ScissorsCutPaper")
                result = .Lose
            }
        } else if userChoice == Selection.scissor {
            switch computerChoice {
            case .rock:
                resultLabel.text = "Rock crushes your Scissor! You Lose!!"
                resultImageView.image = UIImage(named: "RockCrushesScissors")
                result = .Lose
            case .paper:
                resultLabel.text = "Scissor cuts Paper! You Win!!"
                resultImageView.image = UIImage(named: "ScissorsCutPaper")
                result = .Win
            case .scissor:
                tie()
                result = .Tie
            }
        }
        
        storeResult(result: result)
        print(history.count)
    }
    
    
    func storeResult(result : Result) {
        var detail: String = ""
        var title = result.rawValue
        
        guard let userChoice = userSelection else { return }
         guard let computerChoice = computerSelection else { return }
        
        detail = "\(getStringFor(selection: userChoice)) vs \(getStringFor(selection: computerChoice))"
        
        history.append(MatchResults(result: title, detail: detail))
        print(history)
    }
    
    
    func getStringFor(selection: Selection) -> String {
        var string = ""
        
        switch selection {
        case .rock:
            string = "Rock"
        case .paper:
            string = "Paper"
        case .scissor:
            string = "Scissor"
        }
        return string
    }
    
    func tie() {
        resultImageView.image = UIImage(named: "itsATie")
        resultLabel.text = "The game is a Tie!"
    }
    
    //MARK: - Actions
    @IBAction func playAgain(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.userSelection = nil
        }
    }
    
    //MARK: - AutoLayout
    override func viewDidLayoutSubviews() {
        if UIDevice.current.orientation.isLandscape {
            viewTopToSelectionStack.constant = 15
            selectionStackToResult.constant = 20
            resultImagetoText.constant = 15
            resultTextToPlayAgain.constant = 15
        } else {
            viewTopToSelectionStack.constant = 60
            selectionStackToResult.constant = 55.5
            resultImagetoText.constant = 39
            resultTextToPlayAgain.constant = 76.5
        }
    }
    
}
