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


# 🧩 Testing Questions in Swift (XCTest)

## 1. What is unit testing, and why is it important?
Unit testing is a software testing method where individual components or functions are tested in isolation.  
It ensures code correctness, simplifies debugging, and enhances code quality.

---

## 2. How do you set up a unit test target in Xcode?
1. Open your Xcode project.  
2. Select **File > New > Target**.  
3. Choose **Unit Testing Bundle**.  
4. Name the target and click **Finish**.

---

## 3. What is XCTest?
**XCTest** is Apple's testing framework used for writing unit tests and UI tests for iOS, macOS, watchOS, and tvOS applications.

---

## 4. How do you create a test case class using XCTest?
```swift
import XCTest

class MyTests: XCTestCase {
    func testExample() {
        let result = 2 + 2
        XCTAssertEqual(result, 4, "The result should be 4")
    }
}
```

---

## 5. Explain the lifecycle of a test method in XCTest
- `setUp()` : Called before each test method.  
- `tearDown()` : Called after each test method.  
- `setUpWithError()` & `tearDownWithError()` : Handle throwing errors if needed.

---

## 6. What are assertions in unit testing? Provide examples.
```swift
XCTAssert(true) // General assertion
XCTAssertEqual(2 + 2, 4) // Equality check
XCTAssertNotEqual(2 + 2, 5) // Inequality check
XCTAssertNil(nil) // Nil check
XCTAssertNotNil("Hello") // Non-nil check
```

---

## 7. How do you write asynchronous test cases using XCTest?
```swift
func testAsyncCall() {
    let expectation = self.expectation(description: "Async Call")
    
    fetchData { data in
        XCTAssertNotNil(data)
        expectation.fulfill()
    }
    
    waitForExpectations(timeout: 5, handler: nil)
}
```
**Explanation:** XCTest expectations let your test pause until asynchronous code finishes, ensuring you can assert results after async completion.

---

## 8. What are test doubles? Explain mocks, stubs, and fakes.

**Test doubles** are objects that stand in for real objects in tests.  
They simulate or control behavior in a predictable way.

### Mocks — Verify interactions
```swift
class MockPaymentService: PaymentService {
    var sendReceiptCalled = false
    override func sendReceipt() {
        sendReceiptCalled = true
    }
}

// In test
let mockService = MockPaymentService()
checkout.processPayment(service: mockService)
XCTAssertTrue(mockService.sendReceiptCalled)
```

### Stubs — Provide predefined responses
```swift
class WeatherServiceStub: WeatherService {
    override func fetchWeather(for city: String) -> Weather {
        return Weather(temperature: 25, condition: "Sunny")
    }
}
```

### Fakes — Real logic but simpler (in-memory)
```swift
class FakeDatabase: Database {
    private var storage = [String: String]()
    
    override func save(key: String, value: String) {
        storage[key] = value
    }
    
    override func get(key: String) -> String? {
        return storage[key]
    }
}
```
<img width="1536" height="1024" alt="Image" src="https://github.com/user-attachments/assets/383d0651-e63f-4fea-979b-fa97308a5eca" />

---

## 9. What is TDD, and what are its benefits?
**TDD (Test-Driven Development)** involves writing tests before writing the actual implementation code.  

**Cycle:** Red → Green → Refactor

### Example:
```swift
class CalculatorTests: XCTestCase {
    func testAddition() {
        let result = Calculator.add(2, 3)
        XCTAssertEqual(result, 5)
    }
}

struct Calculator {
    static func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
}
```

**Benefits:**
- Reduces bugs  
- Improves design  
- Provides better test coverage  

---

## 10. What is code coverage, and how do you enable it in Xcode?
Code coverage measures how much of the source code is tested by unit tests.

1. Open Xcode.  
2. Go to **Product > Scheme > Edit Scheme...**  
3. Select **Test** and check **Gather Coverage for Targets**.

---

## 11. How do you interpret code coverage reports?
- **Green** → Fully tested code  
- **Red** → Untested code  

---

## 12. What are best practices for writing unit tests?
✅ Write independent tests  
✅ Use meaningful method names  
✅ Test one thing per method  
✅ Use test doubles when needed  
✅ Keep tests readable and maintainable  

---

## 13. How can you prevent unreliable tests?
- Avoid external dependencies  
- Use mock services  
- Ensure consistent test data  

---

## 14. How do you test Core Data models?
Test Core Data models by using an **in-memory persistent container** and validating CRUD operations.
![IMG_8633](https://github.com/user-attachments/assets/d5cf7b3a-c554-4966-b175-16a49f8e1d9d)

---

## 15. How do you test ViewModels in MVVM?
```swift
class ViewModelTests: XCTestCase {
    func testViewModelFetch() {
        let viewModel = MyViewModel(service: MockService())
        viewModel.fetchData()
        XCTAssertEqual(viewModel.data.count, 3)
    }
}
```


## 16. UI Testing with XCUITest

UI tests simulate user actions — tapping buttons, entering text, etc.  
They verify that the app’s interface behaves correctly.

```swift
class UITests: XCTestCase {
    func testLoginFlow() {
        let app = XCUIApplication()
        app.launch()       

        app.textFields["username"].tap()
        app.textFields["username"].typeText("testuser")
        app.buttons["Login"].tap()
        XCTAssertTrue(app.staticTexts["Welcome"].exists)
    }
}
```

### 🧠 Explanation:
- `XCUIApplication()` launches the app.  
- UI elements are accessed by their accessibility identifiers (e.g., `"username"`).  
- `tap()` and `typeText()` simulate user actions.  
- `XCTAssertTrue` checks that a specific UI element exists — confirming successful login.

---

## Testing Strategy

A good testing approach includes all test layers:
- ✅ **Unit Tests** — for `ViewModels`, logic, and data handling.  
- ✅ **UI Tests** — for core user flows such as login, registration, or checkout.  
- ✅ **Integration Tests** — to verify end-to-end behavior using mocked API responses.

Following this layered approach ensures your SwiftUI app remains **stable**, **reliable**, and **easy to maintain**.

