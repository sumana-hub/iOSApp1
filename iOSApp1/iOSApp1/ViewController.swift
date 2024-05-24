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

    //
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound() // Initialize the game when the view loads
    }
    
    // IBActions
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue) // Calculate the difference between the target value and the current value
        let points = 50 - difference // Calculate points based on how close the guess was to the target value
        score += points  // Update the score with the points earned

        // Prepare the message to display in the alert
        let message = "You guessed \(currentValue).\nThe number was \(targetValue).\nYou scored \(points) points."

        // Create and configure the alert controller
        let alert = UIAlertController(
            title: "Result",
            message: message,
            preferredStyle: .alert)

        // Add an action to the alert (OK button) that starts a new round when tapped
        let action = UIAlertAction(
            title: "OK",
            style: .default) { _ in
                self.startNewRound() // Start a new round after the alert is dismissed
            }

        alert.addAction(action) // Add the action to the alert

        present(alert, animated: true, completion: nil) // Present the alert to the user
    }


        @IBAction func sliderMoved(_ slider: UISlider) {
            currentValue = lroundf(slider.value) // Update the current value based on the slider's current position
            guessLabel.text = "\(currentValue)"   // Update the guess label to display the current value
        }

        // Game Logic
        func startNewRound() {
            round += 1 // Increment the round number
            targetValue = Int.random(in: 1...50) // Generate a new random target value between 1 and 50
            currentValue = 25 // Reset the current value to a initial value
            slider.value = Float(currentValue)  // Update the slider's position to match the current value
            updateLabels()  // Update UI labels with new values
        }
    
        // Update UI labels with current values
        func updateLabels() {
            scoreLabel.text = "\(score)" // Update score label
            roundLabel.text = "\(round)" // Update round label
            guessLabel.text = "\(currentValue)" // Update current value
        }


}

