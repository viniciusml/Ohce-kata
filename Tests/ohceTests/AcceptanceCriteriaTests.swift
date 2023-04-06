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
        let printer = PrinterSpy()
        
        expectExit(expectedCode: 1) {
            let sut = Ohce(printer: printer)
            sut.run(nil)
        }
        
        XCTAssertEqual(printer.log, [.print(errorMessage)])
    }
    
    func test_run_withOneArgument_doesNotExitAndGreetsBeforeNoon() throws {
        let argument = "Vini"
        let printer = PrinterSpy()
        let date = try XCTUnwrap(Date(hour: 11, minute: 59))
        
        expectNotToExit {
            let sut = Ohce(printer: printer, date: { date })
            sut.run(argument)
        }
        
        XCTAssertEqual(printer.log, [.print("> ¡Buenos días \(argument)!")])
    }
    
    func test_run_withOneArgument_doesNotExitAndGreetsAfterNoon() throws {
        let argument = "Vini"
        let printer = PrinterSpy()
        let date = try XCTUnwrap(Date(hour: 12, minute: 00))
        
        expectNotToExit {
            let sut = Ohce(printer: printer, date: { date })
            sut.run(argument)
        }
        
        XCTAssertEqual(printer.log, [.print("> ¡Buenas tardes \(argument)!")])
    }
}

private extension AcceptanceCriteriaTests {
    
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
