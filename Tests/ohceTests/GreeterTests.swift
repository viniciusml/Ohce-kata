//
//  GreeterTests.swift
//  
//
//  Created by Vinicius Leal on 05/04/2023.
//

import ohce
import XCTest

final class GreeterTests: XCTestCase {
    
    func test_greet_withoutRunning_doesNotGreet() {
        let sut = makeSUT()
        var greetCallCount = 0
        
        wait(
            for: invertedExpectation(description: #function),
            when: { exp in
                sut.greet { _ in
                    greetCallCount += 1
                    exp.fulfill()
                }
            })
        
        XCTAssertEqual(greetCallCount, 0)
    }
    
    func test_runAndGreet_greetsAfterSix() {
        let argument = "Vini"
        let sut = makeSUT { .date(06) }
        
        sut.run(argument)
        
        XCTAssertEqual(sut.log, ["> ¡Buenos días \(argument)!"])
    }
    
    func test_runAndGreet_greetsBeforeNoon() {
        let argument = "Vini"
        let sut = makeSUT { .date(11, 59) }
        
        sut.run(argument)
        
        XCTAssertEqual(sut.log, ["> ¡Buenos días \(argument)!"])
    }
    
    func test_runAndGreet_greetsAfterNoon() {
        let argument = "Vini"
        let sut = makeSUT { .date(12) }
        
        sut.run(argument)
        
        XCTAssertEqual(sut.log, ["> ¡Buenas tardes \(argument)!"])
    }
    
    func test_runAndGreet_greetsBeforeEight() {
        let argument = "Vini"
        let sut = makeSUT { .date(19, 59) }
        
        sut.run(argument)
        
        XCTAssertEqual(sut.log, ["> ¡Buenas tardes \(argument)!"])
    }
    
    func test_runAndGreet_greetsAfterEight() {
        let argument = "Vini"
        let sut = makeSUT { .date(20, 05) }
        
        sut.run(argument)
        
        XCTAssertEqual(sut.log, ["> ¡Buenas noches \(argument)!"])
    }
    
    func test_runAndGreet_greetsBeforeSix() {
        let argument = "Vini"
        let sut = makeSUT { .date(05, 55) }
        
        sut.run(argument)
        
        XCTAssertEqual(sut.log, ["> ¡Buenas noches \(argument)!"])
    }
    
    func test_sayGoodbye_withoutRunning_doesNotMessageGoodbye() {
        let sut = makeSUT()
        var goodbyeCallCount = 0
        
        wait(
            for: invertedExpectation(description: #function),
            when: { exp in
                sut.sayGoodbye { _ in
                    goodbyeCallCount += 1
                    exp.fulfill()
                }
            })
        
        XCTAssertEqual(goodbyeCallCount, 0)
    }
    
    func test_sayGoodbye_afterRunning_messagesGoodbye() {
        let sut = makeSUT()
        let argument = "Vini"
        var expectedGoodbye = [String]()
        
        wait(
            for: expectation(description: #function),
            when: { exp in
                sut.run(argument)
                    .sayGoodbye {
                        expectedGoodbye.append($0)
                        exp.fulfill()
                    }
            })
        
        XCTAssertEqual(expectedGoodbye, ["> Adios \(argument)"])
    }
}

private extension GreeterTests {
    
    private func makeSUT(
        date: @escaping Greeter.DateFactory = { Date() }
    ) -> Greeter {
        let sut = Greeter(date: date)
        return sut
    }
    
    func wait(for exp: XCTestExpectation, when action: (XCTestExpectation) -> Void) {
        action(exp)
        wait(for: [exp], timeout: 0.1)
    }
    
    func invertedExpectation(description: String) -> XCTestExpectation {
        let exp = expectation(description: description)
        exp.isInverted = true
        return exp
    }
}

private extension Greeter {
    
    var log: [String] {
        var array = [String]()
        greet { greeting in
            array.append(greeting)
        }
        return array
    }
}

private extension Date {
    
    static func date(_ hour: Int, _ minute: Int = 00, file: StaticString = #filePath, line: UInt = #line) -> Self {
        guard let initialisedDate = Date(hour: hour, minute: minute) else {
            XCTFail("Failed to initialise date", file: file, line: line)
            return Date()
        }
        return initialisedDate
    }
}
