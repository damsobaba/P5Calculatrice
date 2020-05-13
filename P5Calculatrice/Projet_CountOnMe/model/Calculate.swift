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
    
     ///Contains the expression
    var text = String() {
        didSet {
            delegate?.updateCalcul(result: text)
        }
    }
    ///This array contains each element of the expression
//    private var elements: [String] {
//        return text.split(separator: " ").map { "\($0)" }
//
//    }
    private var elements: [String] {
           var elements =  text.split(separator: " ").map { "\($0)" }
        if elements.first == "-" {
            elements[1] = "-" + elements[1]
            elements.removeFirst()
        }
           return elements
       }
    
    ///Checks if the last element of the expression is a math operator
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "*" && elements.last != "÷" &&  elements.last != "-"
    }
    /// check if there is enought element to caculate
   private  var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
  
   
    /// check if  there is element to calculate
    private var expressionHaveResult: Bool {
        return text.firstIndex(of: "=") != nil
    }
    
    func  startingWithWrongOperator() {
        var operation = elements
       if (operation[0]) == operators.subtraction.rawValue {
                   operation.remove(at: 0)

               }
             
    }
    private func isStartingWithWrongOperator(mathOperator: operators) -> Bool {
          return text.isEmpty && (mathOperator == operators.multiplication || mathOperator == operators.division)
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
        if expressionHaveResult {// || text.isEmpty {
            delegate?.alertMessage(text: "Vous ne pouvez pas ajouter d'operateur ")
        } // check if a operator can be added
        if (expressionIsCorrect && !text.isEmpty) || (text.isEmpty && operatoree == .subtraction)  {
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
  private func priority(expression: [String]) -> [String] {
        var priorExpression: [String] = expression // car on ne peut pas modifié la constante en parametre
        
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
                priorExpression[index - 1] = String(calcul)// enleve les anciens elements et met le resultat
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
            print("\(elements[1])")
           
             
       startingWithWrongOperator()
          
      
            
           // let minusleft = -Double(operationsToReduce[0])!
           guard let left = Double(operationsToReduce[0]) else {  delegate?.alertMessage(text: "le calcul ne peut pas commencer par cet opérateur")
                return }
//            if (operationsToReduce[0]) == operators.subtraction.rawValue {
//                left = -Double(operationsToReduce[0])!
//
//            }
            
            let operand = operationsToReduce[1]
            guard let right = Double(operationsToReduce[2]) else {return }

           var result: Double
            switch operand {
        
            case "+": result = left + right
            case "-": result = left - right
          
            default: return
            }
         
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            
            operationsToReduce.insert("\(result)", at: 0)
        }
        text.append(" = \(formatResult(result: Double(operationsToReduce.first!)!))")
       
    }
    ////  reduce number of digit display
    private func formatResult(result: Double) -> String {
        let formatter = NumberFormatter()// reduce the nuimber of digit display on result
        formatter.maximumFractionDigits = 3
        formatter.minimumFractionDigits = 0
        guard let resultFormated = formatter.string(from: NSNumber(value: result)) else { return String() }
        return resultFormated
    }
}

// ajouter canaddoperator
