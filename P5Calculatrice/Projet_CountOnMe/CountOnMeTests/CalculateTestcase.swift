//
//  CalculateTestcase.swift
//  CountOnMeTests
//
//  Created by Adam Mabrouki on 11/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe
class CalculateTestcase: XCTestCase {
    var calcultest: Calculate!
    
    override func setUp() {
        calcultest = Calculate()
    }
    
    
    func testGivenAddNumberOneToDisplay_WhenButtonOneTapped_textViewEqualNumberOneTapped() {
        calcultest.addNumber(numberText: "1")
        XCTAssert(calcultest.text == "1")
    }
    
    
    func testGivenCalculIsOnePlusOne_WhenCalculate_resultIsTwo() {
        calcultest.addNumber(numberText: "1")
        calcultest.addOperator(operatoree: .addition)
        calcultest.addNumber(numberText: "1")
        calcultest.total()
        XCTAssert(calcultest.text == "1 + 1 = 2.0")
        
    }
    
    func testGivenCalculIsTwoMinusOne_WhenCalculate_resultIsOne() {
        calcultest.addNumber(numberText: "2")
        calcultest.addOperator(operatoree: .subtraction)
        calcultest.addNumber(numberText: "1")
        calcultest.total()
        XCTAssert(calcultest.text == "2 - 1 = 1.0")
    }
    
    
        func testGivenCalculIsTwoMulipllyByTWO_WhenCalculate_ResultEqualFour() {
             calcultest.addNumber(numberText: "2")
            calcultest.addOperator(operatoree: .multiplication)
             calcultest.addNumber(numberText: "2")
            calcultest.total()
            XCTAssert(calcultest.text == "2 * 2 = 4.0")
    
        }
    
        func testGivenCalculIsFourDividebyTwo_WhenCalculate_ResultIsTwo() {
             calcultest.addNumber(numberText: "4")
            calcultest.addOperator(operatoree: .division)
             calcultest.addNumber(numberText: "2")
            calcultest.total()
            XCTAssert(calcultest.text == "4 ÷ 2 = 2.0")
        }
    
    func testGivenWhenACButtonPressed_textViewIsEmpty() {
        calcultest.addNumber(numberText: "4")
        calcultest.addOperator(operatoree: .division)
        calcultest.refresh()
         XCTAssert(calcultest.text == "")
        
    }
    
    
    
    func testGivenWhenNumberIsDivideByZero_WhenCalculate_TexviewIsEmpty() {
        
        calcultest.addNumber(numberText: "8")
        calcultest.addOperator(operatoree: .division)
        calcultest.addNumber(numberText: "0")
        calcultest.total()
        XCTAssert(calcultest.text == "")
    }
    //    
    //    func testGivenWhenResultIsDisplay_PressNewButtonNumber_TextViewDisplayNewButtonNumber() {
    //        
    //    }
    
    //    tester priorité des operateurs en les utilisants tous
    //    tester le bouton A/C
    //    tester si le texte ne donne pas de calcul si aucun opétateur entré apres le premier nombre
    //
}
