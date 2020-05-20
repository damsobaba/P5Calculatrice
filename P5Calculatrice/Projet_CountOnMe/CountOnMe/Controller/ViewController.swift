//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Outlest
    
    @IBOutlet private weak var textView: UITextView!
    
    // MARK: - Propretie
    
    private let calculate = Calculate()
    
    // MARK: - View life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculate.delegate = self
    }
    
    // MARK: - Actions
    
    @IBAction private func resetButton(_ sender: Any) {
        calculate.refresh()
    }
    
    @IBAction private func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }
        calculate.addNumber(numberText: numberText)
    }
    
    @IBAction private func tappedAdditionButon(_ sender: Any) {
        calculate.addOperator(operatoree: .addition)
    }
   
    @IBAction private func tappedSunbstractionButton(_ sender: Any) {
        calculate.addOperator(operatoree: .subtraction)
    }
    
    @IBAction private func tappedMultiplicationButton(_ sender: Any) {
        calculate.addOperator(operatoree: .multiplication)
    }
    
    @IBAction private func tappedDivisionButton(_ sender: Any) {
        calculate.addOperator(operatoree: .division)
    }
    
    @IBAction private func tappedEqualButton(_ sender: Any) {
        calculate.total()
    }
}

// MARK: - Extansion

extension ViewController: DisplayDelegate {
    ///Assigns the value of the given String to textView.text
    func updateCalcul(result: String) {
        textView.text = result
    }
     ///Presents an alert with the given title and message
    func alertMessage(text: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: text, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}




