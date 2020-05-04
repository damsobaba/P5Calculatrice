//
//  calculate.swift
//  CountOnMe
//
//  Created by Adam Mabrouki on 10/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation


// MARK: - Protocol

protocol AlertDeleguate {
    func alertMessage(text: String)
    func updateCalcul(result: String)
}

class Calculate {
    var delegate: AlertDeleguate?
    var zero = 0
    
    
    //MARK: -Enum
    
    enum operators: String {
        case addition = "+"
        case subtraction = "-"
        case multiplication = "*"
        case division = "÷"
    }
    
    //MARK: - Propreties
    
    var text = String() {
        didSet {
            delegate?.updateCalcul(result: text)
        }
    }
    
    var elements: [String] {
        return text.split(separator: " ").map { "\($0)" }
    }
    
    
    ///Checks if the last element of the expression is a math operator
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "÷"
    }
    /// check if there is enought element to caculate
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    /// check if the last element is not a operator
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "÷"
    }
    /// check if  there is element to calculate
    var expressionHaveResult: Bool {
        return text.firstIndex(of: "=") != nil
    }
    /// check if attempt to divide by 0
    private  var divideByZero: Bool {
        return text.contains("÷ 0")
    }
    
    
    // MARK: - Methods
    
    /// add number to calculation
    func addNumber(numberText: String)  {
        if expressionHaveResult {
            text = ""  }
        text.append(numberText)
    }
    
    /// append a opeator
    func addOperator(operatoree:operators)  {
        if expressionHaveResult || text.isEmpty {
            delegate?.alertMessage(text: "Vous ne pouvez pas ajouter d'operateur ")
        } // check if a operator can be added
        if canAddOperator {
            text.append(" " + operatoree.rawValue + " ")
            
            
        } else {
            delegate?.alertMessage(text: "un opérateur est déja mis ")
            
        }
    }
    
    /// reset text view
    func refresh ()   {
        text = ""
    }
    
    /// check the order of calculation
    private  func priority(expression: [String]) -> [String] {
        var priorExpression: [String] = expression
        
        while priorExpression.contains("*") || priorExpression.contains("÷") {
            if let index = priorExpression.firstIndex(where: {$0 == "*" || $0 == "÷" } ) {
                let operand = priorExpression[index]
                guard let leftSide = Double(priorExpression[index - 1]) else { return [] }
                guard let rightSide = Double(priorExpression[index + 1]) else { return [] }
                
                let calcul: Double
                if operand == "*" {
                    calcul = leftSide * rightSide
                } else {
                    calcul = leftSide / rightSide
                }
                priorExpression[index - 1] = String(calcul)
                priorExpression.remove(at: index + 1)
                priorExpression.remove(at: index)
                
            }
        }
        return priorExpression
    }
    
    /// display total result of calculation
    func total()  {
        guard expressionIsCorrect else {
            delegate?.alertMessage(text: "Entrez une expréssion correcte!")
            return
        }
        guard expressionHaveEnoughElement else {
            delegate?.alertMessage(text: "Démarrez un nouveau calcul")
            
            return
        }
        guard !divideByZero else {
            delegate?.alertMessage(text: "La division par zéro n'existe pas")
            text = ""
            return
        }
        var operationsToReduce = priority(expression: elements)
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!
            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: return
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert(formatResult(result: Double(result)), at: 0)
        }
        text.append(" = \(operationsToReduce.first!)")
    }
    
    //// alow long numbers display
    private func formatResult(result: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 3
        
        guard let resultFormated = formatter.string(from: NSNumber(value: result)) else { return String() }
        
        guard resultFormated.count <= 10 else {
            return String(result)
        }
        return resultFormated
    }
}
// scenedelegate essentiel ?
// pas sur d avoir forké 
// que faire de l ancienne version dans le dossier ? 
//avoir uikit dans le model
