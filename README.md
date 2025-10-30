# 🧪 Unit Testing in Xcode — Complete Guide

## 📘 What is Unit Testing?
Unit Testing is a way to **test individual pieces of code (like functions or view models)** to ensure they work as expected.  
It helps prevent bugs early and ensures changes don’t break existing logic.

✅ **Example:** You test your `Calculator` class’s `divide()` function to verify:
- It gives correct output (e.g., 10 ÷ 2 = 5)
- It throws an error for invalid input (e.g., divide by zero)

---

## ⚙️ How to Create a Test Case File for Your ViewModel

1. Go to your **UnitTestTests** folder in your project bundle.
2. Add a new **XCTestCase** file.  
   In Xcode: `File → New → File → Unit Test Case Class`
3. Name it something like: **CalculatorUnitTestDemoTests**
4. It will automatically include template methods:

### 🧩 Common XCTest Functions

#### `setUpWithError()`  
- Similar to `viewDidLoad` — runs before each test.  
- Use it to create and initialize your test objects.  
- Example: Create your `Calculator` object here.

#### `tearDownWithError()`  
- Runs after each test is done.  
- Used to clean up memory or remove test objects.  
- Example: Set `calculator = nil` here.

---

## 🧰 Importing Your Main Target (Project)

Since your **Calculator** class is inside another target (the main app target),  
you must import it using:

```swift
@testable import CalculatorUnitTestDemo
```

*(Replace `CalculatorUnitTestDemo` with your actual project name)*

This allows your test file to access internal methods and classes from your app.

---

## 🧠 XCTest Naming Rule

All your test functions **must start with `test`**.  
Example:
```swift
func testDivideSuccess() { ... }
```

---

## 🧪 Explanation of Each Assertion

| Assertion | Purpose | Example |
|------------|----------|----------|
| `XCTAssertEqual(a, b)` | Checks if two values are equal | `5 == 5` |
| `XCTAssertTrue(expr)` | Passes if condition is true | `result == 5` |
| `XCTAssertFalse(expr)` | Passes if condition is false | `result == 0` |
| `XCTAssertNil(value)` | Passes if value is nil | `value == nil` |
| `XCTAssertNotNil(value)` | Passes if value is not nil | object exists |
| `XCTAssertThrowsError(expr)` | Checks if expression throws an error | dividing by zero |
| `XCTFail("message")` | Manually fails a test with a message | unexpected condition |

---

## 📊 What is Code Coverage?

Code Coverage helps measure **how much of your code is tested** through Unit Tests.

### 💡 Key Points:
- Shows the **percentage of code covered** by your test cases.  
- You can check **which lines were tested (green)** and **which were not (red)**.  
- Found in Xcode under **Report Navigator → Coverage tab**.  
- Aim for **80% or higher** for a well-tested app.  
- Works for both **Unit Tests** and **UI Tests**.

---
<img width="1397" height="310" alt="Screenshot 2025-10-30 at 3 05 01 PM" src="https://github.com/user-attachments/assets/2327e750-da6b-474e-882e-2747ed9b1004" />



## ✅ Example Checklist for Unit Testing Setup

- [x] Created `Calculator.swift` (main logic)
- [x] Created `CalculatorTests.swift` under *UnitTestTests*
- [x] Added setup and teardown
- [x] Imported project target using `@testable import`
- [x] Wrote test cases using `XCTAssertEqual`, `XCTAssertTrue`, etc.
- [x] Viewed test results and code coverage in Xcode

---

🧩 **Tip:** Always test your important logic like login validation, API parsing, or calculation functions using Unit Tests to make your app reliable and bug-free!

---
Code - Calculator.swift
---
```
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

```

---
CalculatorUnitTestDemoTests
---
```
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
```
