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
        let lineProvider = LineProviderStub(line: ["hola"])
        let sut = LineInterpreter(lineProvider: lineProvider)
        var receivedWords = [String]()
        
        sut.processLine()
            .reversed {
                receivedWords.append($0)
            }
        
        XCTAssertEqual(receivedWords, ["aloh"])
    }
}

private extension LineInterpreterTests {
    
    final class LineProviderStub: LineProviding {
        
        private var input: [String]
        
        init(line: [String]) {
            self.input = line
        }
        
        func readLine() -> String? {
            let next = input.first
            input.removeFirst()
            return next
        }
    }
}
