//
//  LineReaderTests.swift
//  
//
//  Created by Vinicius Leal on 09/04/2023.
//

import ohce
import XCTest

final class LineInterpreterTests: XCTestCase {
    
    func test_nextLine_withRegularInput() {
        let sut = LineInterpreter()
        var receivedWords = [String]()
        
        sut.processLine("hola")
            .reversed {
                receivedWords.append($0)
            }
        
        XCTAssertEqual(receivedWords, ["aloh"])
    }
}
