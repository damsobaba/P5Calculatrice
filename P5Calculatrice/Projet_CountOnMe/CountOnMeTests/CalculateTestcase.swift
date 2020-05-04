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
    //MARK: - test numbers
    
    /// add number test
    func testGivenAddNumberOneToDisplay_WhenButtonOneTapped_textViewEqualNumberOneTapped() {
        calcultest.addNumber(numberText: "1")
        XCTAssert(calcultest.text == "1")
    }
    /// check if pass to knew operation after total
    func testGivenCalculOnePlusOne_WhenAddTwo_ThenTextIsTwo(){
        calcultest.addNumber(numberText: "1")
        calcultest.addOperator(operatoree: .addition)
        calcultest.addNumber(numberText: "1")
        calcultest.total()
        
        calcultest.addNumber(numberText: "6")
        
        XCTAssert(calcultest.text == "6")
    }
    
    // MARK: - test operators
    
    
    /// add operateur plus test
    func testGivenCalculIsOnePlusOne_WhenCalculate_resultIsTwo() {
        calcultest.addNumber(numberText: "1")
        calcultest.addOperator(operatoree: .addition)
        calcultest.addNumber(numberText: "1")
        calcultest.total()
        XCTAssert(calcultest.text == "1 + 1 = 2")
        
    }
    
    /// add operator minus test
    func testGivenCalculIsTwoMinusOne_WhenCalculate_resultIsOne() {
        calcultest.addNumber(numberText: "2")
        calcultest.addOperator(operatoree: .subtraction)
        calcultest.addNumber(numberText: "1")
        calcultest.total()
        XCTAssert(calcultest.text == "2 - 1 = 1")
    }
    
    /// add operator multiply test
    func testGivenCalculIsTwoMulipllyByTWO_WhenCalculate_ResultEqualFour() {
        calcultest.addNumber(numberText: "2")
        calcultest.addOperator(operatoree: .multiplication)
        calcultest.addNumber(numberText: "2")
        calcultest.total()
        XCTAssert(calcultest.text == "2 * 2 = 4.0")
        
    }
    
    /// add operator divide test
    func testGivenCalculIsFourDividebyTwo_WhenCalculate_ResultIsTwo() {
        calcultest.addNumber(numberText: "4")
        calcultest.addOperator(operatoree: .division)
        calcultest.addNumber(numberText: "2")
        calcultest.total()
        XCTAssert(calcultest.text == "4 ÷ 2 = 2.0")
    }
    /// test priority operator
    func testGivenWhenAddOperatorPlusandMultiply_WhenCalculate_resultMultiplyFirst() {
        calcultest.addNumber(numberText: "2")
        calcultest.addOperator(operatoree: .addition)
        calcultest.addNumber(numberText: "4")
        calcultest.addOperator(operatoree: .multiplication)
        calcultest.addNumber(numberText: "4")
        calcultest.total()
        XCTAssert(calcultest.text == "2 + 4 * 4 = 18")
    }
    /// reset button test
    func testGivenWhenACButtonPressed_textViewIsEmpty() {
        calcultest.addNumber(numberText: "4")
        calcultest.addOperator(operatoree: .division)
        calcultest.refresh()
        XCTAssert(calcultest.text == "")
    }
    /// divide buy 0 test
    func testGivenWhenNumberIsDivideByZero_WhenCalculate_TexviewIsEmpty() {
        
        calcultest.addNumber(numberText: "8")
        calcultest.addOperator(operatoree: .division)
        calcultest.addNumber(numberText: "0")
        calcultest.total()
        XCTAssert(calcultest.text == "")
    }
    // MARK: - testing Notification
    /// test error two operator
    func testGivenCalculTextAddOperator_WhenTwoOperatorAreTapped_ThendNotificationAppear() {
        calcultest.addNumber(numberText: "2")
        calcultest.addOperator(operatoree: .subtraction)
        calcultest.addOperator(operatoree: .subtraction)
        XCTAssert(calcultest.text == "2 - ")
    }
    /// test not adding element to calculate 
    func testGivenExpressionHaveEnoughElement_WhenMissElements_ThendNotificationAppear() {
        calcultest.addNumber(numberText: "5")
        calcultest.total()
        XCTAssert(calcultest.text == "5")
    }
    /// test not adding element after operator
    func testGivenWhenAddNumberandOperator_WhenCalculate_resultdisplayAlert() {
        calcultest.addNumber(numberText: "8")
        calcultest.addOperator(operatoree: .addition)
        calcultest.total()
        XCTAssert(calcultest.text == "8 + ")
    }
    /// test adding a operator on result
    func testGivenAddOperator_WhenOperationHaveResult_ThenShouldNotification() {
        calcultest.addNumber(numberText: "1")
        calcultest.addOperator(operatoree: .addition)
        calcultest.addNumber(numberText: "1")
        calcultest.total()
        calcultest.addOperator(operatoree: .addition)
        XCTAssert(calcultest.text == "1 + 1 = 2 + ")
    }
    // MARK: - testing formateur
    /// test precice result
    func testGivenCalculisOneUndreedDivideBy3_WhenCalculate_ResultIsMultipleElementAfterVirgule() {
        calcultest.addNumber(numberText: "100")
        calcultest.addOperator(operatoree: .division)
        calcultest.addNumber(numberText: "3")
        calcultest.total()
        XCTAssert(calcultest.text == "100 ÷ 3 = 33.333333333333336")
    }
    /// test  displaying large number calculation
    func testGivenCalculIsOneAndTenZeroPLusOneAndTenZero_WhenCalculate_AllTheResultiSDisplay() {
        calcultest.addNumber(numberText: "10000000000")
        calcultest.addOperator(operatoree: .addition)
        calcultest.addNumber(numberText: "10000000000")
        calcultest.total()
        XCTAssert(calcultest.text == "10000000000 + 10000000000 = 20000000000.0")
    }
    

}
