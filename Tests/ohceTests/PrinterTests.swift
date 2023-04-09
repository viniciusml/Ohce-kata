//
//  PrinterTests.swift
//  
//
//  Created by Vinicius Leal on 09/04/2023.
//

import ohce
import XCTest

final class PrinterTests: XCTestCase {
    
    func test_logMessage() {
        expectPrint(expectedMessage: "a message") {
            let sut = Printer()
            sut.log("a message")
        }
    }
}
