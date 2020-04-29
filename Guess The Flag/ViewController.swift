//
//  ViewController.swift
//  Guess The Flag
//
//  Created by Alejandro Barranco on 29/04/20.
//  Copyright © 2020 Alejandro Barranco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var track = 5
    var correctAnswer = 0 {
        didSet {
            title = "\(countries[correctAnswer].uppercased()). Score \(score)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button2.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button3.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showScore))
    }

    @objc func showScore() {
        let vc = UIAlertController(title: "Your score is", message: "\(score)", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "continue", style: .default, handler: nil))
        present(vc, animated: true, completion: nil)
    }
    
    func askQuestion(action: UIAlertAction? = nil) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame(action: UIAlertAction?) {
        score = 0
        track = 5
        askQuestion()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Incorrect"
            score -= 1
        }
        
        track -= 1
        if track == 0 {
            let alertController = UIAlertController(title: "End Game", message: "Your final score: \(score)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: resetGame))
            present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: title, message: (sender.tag == correctAnswer ? "Your score: \(score)" : "Wrong!, That's the flag of \(countries[sender.tag].localizedUppercase)"), preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(alertController, animated: true, completion: nil)
        }
    }
}

