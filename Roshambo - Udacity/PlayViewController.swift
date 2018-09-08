//
//  PlayViewController.swift
//  Roshambo - Udacity
//
//  Created by Vigneshraj Sekar Babu on 8/19/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    //Constraints
    @IBOutlet weak var titleToSubtitle: NSLayoutConstraint!
    @IBOutlet weak var playLabelToStackView: NSLayoutConstraint!
    @IBOutlet weak var viewTopToTitle: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
              checkDeviceOrientation()
    }

    @IBAction func rockSelected(_ sender: UIButton) {
        let destinationVC : ResultViewController = storyboard?.instantiateViewController(withIdentifier: "resultsViewController") as! ResultViewController
        destinationVC.userSelection = Selection.rock
        present(destinationVC, animated: true, completion: nil)
    }
    
    @IBAction func paperSelected(_ sender: Any) {
        performSegue(withIdentifier: "paperSelected", sender: self)
        
    }
    
    @IBAction func scissorsSelected(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "paperSelected" {
            if let destinationVC = segue.destination as? ResultViewController {
                destinationVC.userSelection = Selection.paper
            }
        } else if segue.identifier == "scissorsSelected" {
            if let destinationVC = segue.destination as? ResultViewController {
                destinationVC.userSelection = Selection.scissor
            }
        }
    }

    //MARK:- AutoLayout
    override func viewDidLayoutSubviews() {
          checkDeviceOrientation()
    }
    
    func checkDeviceOrientation(){
        if UIDevice.current.orientation.isLandscape {
            constraintsForLandscape()
        } else {
            constraintsForPortrait()
        }
    }
    
    func constraintsForLandscape() {
        viewTopToTitle.constant = 30
        titleToSubtitle.constant = 10
        playLabelToStackView.constant = 100
    }
    
    func constraintsForPortrait(){
        viewTopToTitle.constant = 109.0
        titleToSubtitle.constant = 14.5
        playLabelToStackView.constant = 234.5
    }
    
}

//MARK: - Enum for Selection Types
enum Selection: Int {
    case rock = 0
    case paper = 1
    case scissor = 2
}

enum Result: String {
    case Win, Lose, Tie, None
}

