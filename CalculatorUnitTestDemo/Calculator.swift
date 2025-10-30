//
//  Calculator.swift
//  CalculatorUnitTestDemo
//
//  Created by                     Nand Parikh on 30/10/25.
//

import Foundation

enum CalculatorError: Error {
    case divisionByZero
}

final class Calculator {
    func add(a : Int, b : Int) -> Int{
        return a + b
    }
    
    func divide(a : Double, b : Double) throws -> Double {
        guard b != 0 else {
            throw CalculatorError.divisionByZero
        }
        return a / b
    }
}
