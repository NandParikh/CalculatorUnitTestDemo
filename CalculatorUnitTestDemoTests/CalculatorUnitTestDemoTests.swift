//
//  CalculatorUnitTestDemoTests.swift
//  CalculatorUnitTestDemoTests
//
//  Created by                     Nand Parikh on 30/10/25.
//

import XCTest
@testable import CalculatorUnitTestDemo

final class CalculatorUnitTestDemoTests: XCTestCase {
    
    var calculator : Calculator!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        calculator = Calculator()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        calculator = nil
    }
    
    // ✅ 1. Normal Add Two Number test
    func testAddTwoNumbers(){
        // Arrange
        let a = 2, b = 3
        
        // Act
        let result = calculator.add(a: a, b: b)
        
        // Assert
        XCTAssertEqual(result, 5, "2 + 3 should be 5")
    }
    
    // ✅ 2. Normal division test
    func testDivisionSuccess() throws{
        
        // Arrange
        let a : Double = 15
        let b : Double = 3
        
        // Act
        let result = try calculator.divide(a: a, b: b)
        
        // Assert
        XCTAssertEqual(result, 5.0)
        
        
        // True / False checks
        XCTAssertTrue(result == 5, "Result should be exactly 5")
        XCTAssertFalse(result == 0, "Result should not be 0")
    }
    
    // ✅ 2. Division by zero test
    func testDivideByZeroThrows() {
        // Arrange
        let a: Double = 10
        let b: Double = 0
        
        // Act & Assert
        XCTAssertThrowsError(try calculator.divide(a: a, b: b)) { error in
            XCTAssertEqual(error as? CalculatorError, CalculatorError.divisionByZero)
        }
    }
    
    // ✅ 3. Example: Nil and NotNil
    func testCalculatorNotNil() {
        XCTAssertNotNil(calculator, "Calculator instance should not be nil")
    }
    
    func testOptionalResultNil() {
        let optionalResult: Double? = nil
        XCTAssertNil(optionalResult, "Optional result should be nil before calculation")
    }
    
    // ✅ 4. XCTFail Example (Forcing a failure)
    func testFailExample() {
        let condition = true
        
        if !condition {
            XCTFail("Forced failure: Condition was false when it should have been true")
        }
    }
}

/*
 
How to create test case file for your view model
Go to your UnitTestTests folder in bundle
Add new XCTestUnitTest file
Name it like : CalculatorUnitTestDemo
It will have below functions

setUpWithError -
One type of didLoad,
You can make initializations in it.
You will make a Calculator object in it.

tearDownWithError -
Remove objects after the test case,
They will be removed from the memory.
We will make objects nil in it.
You will remove the view model object in it.
     
Important Notes:
You will not directly use Calculator object in your test case file ,
because it is in other target so,

You have to import it by below
@testable import CalculatorUnitTestDemo (Your Project (Main Target) Name)
     
Your test file inherit the XCTestCase
You must have to write test as prefix to the function of your test cases
 
 
 🧠 Explanation of Each Assertion
 Assertion    Purpose    Example
 XCTAssertEqual(a, b)    Checks if two values are equal    5 == 5
 XCTAssertTrue(expr)    Passes if condition is true    result == 5
 XCTAssertFalse(expr)    Passes if condition is false    result == 0
 XCTAssertNil(value)    Passes if value is nil    value == nil
 XCTAssertNotNil(value)    Passes if value is not nil    object exists
 XCTAssertThrowsError(expr)    Checks if expression throws an error    dividing by zero
 XCTFail("message")    Manually fails a test with a message
 
 What is Code Coverage
 - It will show how many percentage of test cases written for your application
 - It will show testable percentage for each file
 - You can see which line is not included in test case and which are included
 - You can see it from left panel(Report Navigator)
 - more than 80% code coverage is good for your application
 - It will show for both unit test case and code test cases
 */
