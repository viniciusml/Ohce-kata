//
//  XCTestCase+Overrides.swift
//  
//
//  Created by Vinicius Leal on 05/04/2023.
//

import ohce
import XCTest

extension XCTestCase {
    func expectExit(expectedCode: Int32, testcase: @escaping () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "expecting Exit")
        var errorCode: Int32? = nil
        
        ExitUtil.replaceExit { code in
            errorCode = code
            exp.fulfill()
            self.unreachable()
            
        }
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)
        
        waitForExpectations(timeout: 0.5) { _ in
            XCTAssertEqual(errorCode, expectedCode, file: file, line: line)
            
            ExitUtil.restoreExit()
        }
    }
    
    func expectNotToExit(testcase: @escaping () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "expecting not to Exit")
        exp.isInverted = true
        
        ExitUtil.replaceExit { _ in
            XCTFail("Expected app not to exit", file: file, line: line)
            exp.fulfill()
            self.unreachable()
        }
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)
        
        waitForExpectations(timeout: 0.5) { _ in
            ExitUtil.restoreExit()
        }
    }
    
    private func unreachable() -> Never {
        repeat {
            RunLoop.current.run()
        } while (true)
    }
}
