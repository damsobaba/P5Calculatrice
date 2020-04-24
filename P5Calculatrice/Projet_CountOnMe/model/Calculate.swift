//
//  calculate.swift
//  CountOnMe
//
//  Created by Adam Mabrouki on 10/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol AlertDeleguate {
    func alertMessage(text: String)
    func updateCalcul(result: String)
}

class Calculate {
    var delegate: AlertDeleguate?
    var zero = 0
    
    enum operators: String {
        case addition = "+"
        case subtraction = "-"
        case multiplication = "*"
        case division = "÷"
    }
    
    var text = String() {
        didSet {
            delegate?.updateCalcul(result: text)
        }
    }
    
    var elements: [String] {
        return text.split(separator: " ").map { "\($0)" }
        
    }
    
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "÷"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "÷"
    }
    
    var expressionHaveResult: Bool {
        return text.firstIndex(of: "=") != nil
    }
    
    
    
    func addNumber(numberText: String)  {
        
        if expressionHaveResult {
            text = ""
        }
        text.append(numberText)
        
        
    }
    
    func addOperator(operatoree:operators)  {
        
        if canAddOperator {
            text.append(" " + operatoree.rawValue + " ")
            
            
        } else {
            delegate?.alertMessage(text: "un opérateur est déja mis ")
         
        }
       
    }
    
   var divideByZero: Bool {
        return text.contains("÷ 0")
    }
            
    
        
        
        
    
    func refresh ()   {
        text = ""
    }
    
    func total()  {
        

        guard expressionIsCorrect else {
            delegate?.alertMessage(text: "Entrez une expréssion correcte!")
            return
        }
        guard expressionHaveEnoughElement else {
            delegate?.alertMessage(text: "Démarrez un nouveau calcul")
            
            return
        }
        guard !divideByZero else { // why exclamation point 
                   delegate?.alertMessage(text: "La division par zéro n'existe pas")
             text = ""
            return
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
//
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])! // debalé correctement
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])! // debalé correctement
            
            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "*": result = left * right
            case "÷": result = left / right
            default: return
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        text.append(" = \(operationsToReduce.first!)")
        
        //            return self.present(alertVC, animated: true, completion: nil); text
        
    }
    
    
}





