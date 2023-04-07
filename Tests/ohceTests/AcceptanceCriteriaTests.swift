//
//  AcceptanceCriteriaTests.swift
//  
//
//  Created by Vinicius Leal on 05/04/2023.
//

import ohce
import XCTest

final class AcceptanceCriteriaTests: XCTestCase {
    
    func test_run_withNoArguments_exitsAppWithErrorAndMessage() {
        let errorMessage = "Error: no argument passed"
        let (sut, printer) = makeSUT()
        
        expectExit(expectedCode: 1) {
            sut.run(nil)
        }
        
        XCTAssertEqual(printer.log, [.print(errorMessage)])
    }
    
    func test_run_withOneArgument_doesNotExitAndGreetsBeforeNoon() throws {
        let argument = "Vini"
        let (sut, printer) = makeSUT { .date(11, 59) }
        
        runWithNoExit(argument: argument, on: sut, andAssert: {
            XCTAssertEqual(printer.log, [.print("> ¡Buenos días \(argument)!")])
        })
    }
    
    func test_run_withOneArgument_doesNotExitAndGreetsAfterNoon() throws {
        let argument = "Vini"
        let (sut, printer) = makeSUT { .date(12) }
        
        runWithNoExit(argument: argument, on: sut, andAssert: {
            XCTAssertEqual(printer.log, [.print("> ¡Buenas tardes \(argument)!")])
        })
    }
}

private extension AcceptanceCriteriaTests {
    
    private func makeSUT(
        date: @escaping Ohce.DateFactory = { Date() }
    ) -> (sut: Ohce, printer: PrinterSpy) {
        let printer = PrinterSpy()
        let sut = Ohce(printer: printer, date: date)
        return (sut, printer)
    }
    
    private func runWithNoExit(argument: String, on sut: Ohce, andAssert assertion: () -> Void) {
        expectNotToExit {
            sut.run(argument)
        }
        assertion()
    }
    
    final class PrinterSpy: Printable {
        enum MethodCall: Equatable, CustomStringConvertible {
            case print(String)
            
            var description: String {
                switch self {
                case .print(let message):
                    return ".print(\(message))"
                }
            }
        }
        
        private(set) var log = [MethodCall]()
        
        func log(_ message: String) {
            log.append(.print(message))
        }
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
