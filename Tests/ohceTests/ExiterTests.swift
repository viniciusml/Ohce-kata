//
//  ExiterTests.swift
//  
//
//  Created by Vinicius Leal on 08/04/2023.
//

import ohce
import XCTest

final class ExiterTests: XCTestCase {
    
    func test_exit_withCode() {
        expectExit(expectedCode: 1) {
            let sut = Exiter()
            sut.exit(1)
        }
    }
}
