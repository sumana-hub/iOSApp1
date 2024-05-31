//
//  ViewController.swift
//  iOSApp1
//
//  Created by Sumana Dhital on 2024-05-23.
//

import UIKit

class ViewController: UIViewController {

    // Outlets
    @IBOutlet var slider: UISlider!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!
    @IBOutlet var guessLabel: UILabel!

    // Properties
    var currentValue: Int = 0
    var targetValue = 0
    var score = 0
    var round = 0

    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNewGame() // Start new game when the view loads
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Highlighted-1")!
        slider.setThumbImage(thumbImageNormal, for: .normal)

        let thumbImageHighlighted = UIImage(
          named: "SliderThumb-Normal-1")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)

        let insets = UIEdgeInsets(
          top: 0,
          left: 14,
          bottom: 0,
          right: 14)

        let trackLeftImage = UIImage(named: "SliderTrackLeft-1")!
        let trackLeftResizable = trackLeftImage.resizableImage(
          withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)

        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(
          withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)

    }
    
    // IBActions
    @IBAction func showAlert() {
        // Calculate the difference between the target value and the current value
        let difference = abs(targetValue - currentValue)
        
        // Use var instead of let since points might be modified
        var points = 100 - difference

        // Determine the title for the alert based on the difference and add bonus points if applicable
        let title: String
        if difference == 0 {
            title = "Spot On!"
            points += 100  // Award bonus points for a perfect guess
        } else if difference < 5 {
            title = "Almost There!"
            if difference == 1 {
                points += 50  // Award additional bonus points for being just 1 off
            }
        } else if difference < 10 {
            title = "Good Guess!"
        } else {
            title = "Better Luck Next Time!"
        }

        // Update the score with the points earned, including any bonus points
        score += points

        // Prepare the message to display in the alert
        let message = "You scored \(points) points."

        // Create and configure the alert controller
        let alert = UIAlertController(
            title: title,  // Use the determined title
            message: message,
            preferredStyle: .alert)

        // Add an action to the alert (OK button) that starts a new round when tapped
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                self.startNewRound() // Start a new round after the alert is dismissed
            })

        // Add the action to the alert
        alert.addAction(action)

        // Present the alert to the user
        present(alert, animated: true, completion: nil)
    }


        @IBAction func sliderMoved(_ slider: UISlider) {
            currentValue = lroundf(slider.value) // Update the current value based on the slider's current position
            guessLabel.text = "\(currentValue)"   // Update the guess label to display the current value
        }

        // Game Logic
        func startNewRound() {
            round += 1 // Increment the round number
            targetValue = Int.random(in: 1...50) // Generate a new random target value between 1 and 50
            currentValue = 0 // Reset the current value to a initial value
            slider.value = Float(currentValue)  // Update the slider's position to match the current value
            updateLabels()  // Update UI labels with new values
        }
    
        // Start New Game
        @IBAction func startNewGame() {
            score = 0
            round = 0
            startNewRound()
            
            //Transition
            let transition = CATransition()
              transition.type = CATransitionType.fade
              transition.duration = 1
              transition.timingFunction = CAMediaTimingFunction(
                name: CAMediaTimingFunctionName.easeOut)
              view.layer.add(transition, forKey: nil)
        }

    
        // Update UI labels with current values
        func updateLabels() {
            scoreLabel.text = "\(score)" // Update score label
            roundLabel.text = "\(round)" // Update round label
            guessLabel.text = "\(currentValue)" // Update current value
        }


}

