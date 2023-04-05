//
//  AcceptanceCriteriaTests.swift
//  
//
//  Created by Vinicius Leal on 05/04/2023.
//

import ohce
import XCTest

final class AcceptanceCriteriaTests: XCTestCase {
    
    func test_run_withNoArguments_exitsAppWithError() {
        expectExit(expectedCode: 1) {
            let sut = Ohce()
            
            sut.run(nil)
        }
    }
}
