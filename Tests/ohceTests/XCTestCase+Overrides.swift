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
        
        waitForExpectations(timeout: 0.1) { _ in
            XCTAssertEqual(errorCode, expectedCode, file: file, line: line)
            
            ExitUtil.restoreExit()
        }
    }
    
    func expectPrint(expectedMessage: String, testcase: @escaping () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "expecting Print")
        var receivedMessage: String? = nil
        
        PrintUtil.replacePrint { message in
            receivedMessage = message
            exp.fulfill()
            self.unreachable()
            
        }
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)
        
        waitForExpectations(timeout: 0.1) { _ in
            XCTAssertEqual(receivedMessage, expectedMessage, file: file, line: line)
            
            PrintUtil.restorePrint()
        }
    }
    
    func stubReadLine(_ stubbedLine: String, testcase: @escaping () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "expecting Print")
        
        ReadLineUtil.replaceReadLine { _ in
            exp.fulfill()
            return stubbedLine
        }
        
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)
        
        waitForExpectations(timeout: 0.1) { _ in
            ReadLineUtil.restoreReadLine()
        }
    }
    
    private func unreachable() -> Never {
        repeat {
            RunLoop.current.run()
        } while (true)
    }
}
