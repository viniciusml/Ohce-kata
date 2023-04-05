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
}

private extension AcceptanceCriteriaTests {
    
    final class PrinterSpy: Printable {
        enum MethodCall: Equatable {
            case print(String)
        }
        
        private(set) var log = [MethodCall]()
        
        func log(_ message: String) {
            log.append(.print(message))
        }
    }
}
