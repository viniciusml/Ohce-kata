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
        let exp = expectation(description: #function)
        exp.isInverted = true
        var greetCallCount = 0
        
        sut.greet { _ in
            greetCallCount += 1
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 0.1)
        XCTAssertEqual(greetCallCount, 0)
    }
    
    func test_run_withOneArgument_doesNotExitAndGreetsAfterSix() {
        let argument = "Vini"
        let sut = makeSUT { .date(06) }
        
        sut.run(argument)
        
        XCTAssertEqual(sut.log, ["> ¡Buenos días \(argument)!"])
    }
    
    func test_run_withOneArgument_doesNotExitAndGreetsBeforeNoon() {
        let argument = "Vini"
        let sut = makeSUT { .date(11, 59) }
        
        sut.run(argument)
        
        XCTAssertEqual(sut.log, ["> ¡Buenos días \(argument)!"])
    }
    
    func test_run_withOneArgument_doesNotExitAndGreetsAfterNoon() {
        let argument = "Vini"
        let sut = makeSUT { .date(12) }
        
        sut.run(argument)
        
        XCTAssertEqual(sut.log, ["> ¡Buenas tardes \(argument)!"])
    }
    
    func test_run_withOneArgument_doesNotExitAndGreetsBeforeEight() {
        let argument = "Vini"
        let sut = makeSUT { .date(19, 59) }
        
        sut.run(argument)
        
        XCTAssertEqual(sut.log, ["> ¡Buenas tardes \(argument)!"])
    }
    
    func test_run_withOneArgument_doesNotExitAndGreetsAfterEight() {
        let argument = "Vini"
        let sut = makeSUT { .date(20, 05) }
        
        sut.run(argument)
        
        XCTAssertEqual(sut.log, ["> ¡Buenas noches \(argument)!"])
    }
    
    func test_run_withOneArgument_doesNotExitAndGreetsBeforeSix() {
        let argument = "Vini"
        let sut = makeSUT { .date(05, 55) }
        
        sut.run(argument)
        
        XCTAssertEqual(sut.log, ["> ¡Buenas noches \(argument)!"])
    }
    
    func test_sayGoodbye_withoutRunning_doesNotMessageGoodbye() {
        let sut = makeSUT()
        let exp = expectation(description: #function)
        exp.isInverted = true
        var goodbyeCallCount = 0
        
        sut.sayGoodbye { _ in
            goodbyeCallCount += 1
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 0.1)
        XCTAssertEqual(goodbyeCallCount, 0)
    }
    
    func test_sayGoodbye_afterRunning_messagesGoodbye() {
        let sut = makeSUT()
        let argument = "Vini"
        let exp = expectation(description: #function)
        var goodbyeCallCount = 0
        var expectedGoodbye: String?
        
        sut.run(argument)
            .sayGoodbye { goodbye in
                goodbyeCallCount += 1
                expectedGoodbye = goodbye
                exp.fulfill()
            }
        
        wait(for: [exp], timeout: 0.1)
        XCTAssertEqual(goodbyeCallCount, 1)
        XCTAssertEqual(expectedGoodbye, "> Adios \(argument)")
    }
}

private extension GreeterTests {
    
    private func makeSUT(
        date: @escaping Greeter.DateFactory = { Date() }
    ) -> Greeter {
        let sut = Greeter(date: date)
        return sut
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
