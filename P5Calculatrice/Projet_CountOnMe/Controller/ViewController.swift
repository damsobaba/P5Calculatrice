//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    @IBOutlet weak var resetView: UIButton!
    
    
    
    var calculate = Calculate()

    override func viewDidLoad() {
        super.viewDidLoad()
        calculate.delegate = self
        
    }
    
    @IBAction func resetButton(_ sender: Any) {
        
        calculate.refresh()
        
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
    
        
        calculate.addNumber(numberText: numberText)
    }
    
    @IBAction func tappedAdditionButon(_ sender: Any) {
        calculate.addOperator(operatoree: .addition)
        
    }
    //
    @IBAction func tappedSunbstractionButton(_ sender: Any) {
        calculate.addOperator(operatoree: .subtraction)
    }
   
    @IBAction func tappedMultiplicationButton(_ sender: Any) {
         calculate.addOperator(operatoree: .multiplication)
    }
   
    @IBAction func tappedDivisionButton(_ sender: Any) {
       calculate.addOperator(operatoree: .division)
    }
    
    @IBAction func tappedEqualButton(_ sender: Any) {
        
       calculate.total()
        
    }
    
}

extension ViewController: AlertDeleguate {
    func updateCalcul(result: String) {
        textView.text = result
    }
    
    func alertMessage(text: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}




