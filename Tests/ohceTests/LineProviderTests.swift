//
//  LineProviderTests.swift
//  
//
//  Created by Vinicius Leal on 10/04/2023.
//

import ohce
import XCTest

final class LineProviderTests: XCTestCase {
    
    func test_provide_withNoLine() {
        stubReadLine("aloha") {
            let sut = LineProvider()
            
            XCTAssertEqual(sut.provide(), "aloha")
        }
    }
}

