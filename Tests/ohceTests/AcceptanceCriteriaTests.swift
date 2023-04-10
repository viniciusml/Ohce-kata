//
//  AcceptanceCriteriaTests.swift
//  
//
//  Created by Vinicius Leal on 05/04/2023.
//

import ohce
import XCTest

final class AcceptanceCriteriaTests: XCTestCase {
    
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
}

private extension AcceptanceCriteriaTests {
    
    private func makeSUT(
        date: @escaping Ohce.DateFactory = { Date() }
    ) -> Ohce {
        let sut = Ohce(date: date)
        return sut
    }
}

private extension Ohce {
    
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
