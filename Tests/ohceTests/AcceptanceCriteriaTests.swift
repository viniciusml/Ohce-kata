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

extension XCTestCase {
    func expectExit(expectedCode: Int32, testcase: @escaping () -> Void) {
        let exp = expectation(description: "expecting Exit")
        var errorCode: Int32? = nil
        
        ExitUtil.replaceExit { code in
            errorCode = code
            exp.fulfill()
            self.unreachable()
            
        }
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)
        
        waitForExpectations(timeout: 0.5) { _ in
            XCTAssertEqual(errorCode, expectedCode)
            
            ExitUtil.restoreExit()
        }
    }
    
    private func unreachable() -> Never {
        repeat {
            RunLoop.current.run()
        } while (true)
    }
}
