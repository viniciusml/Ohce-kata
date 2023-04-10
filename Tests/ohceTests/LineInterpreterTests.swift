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
        var receivedPalindromes = [String]()
        var stopActionCount = 0
        
        sut.processLine("hola")
            .reversed {
                receivedWords.append($0)
            }
            .palindrome {
                receivedPalindromes.append($0)
            }
            .stop {
                stopActionCount += 1
            }
        
        XCTAssertEqual(receivedWords, ["aloh"])
        XCTAssertEqual(receivedPalindromes, [])
        XCTAssertEqual(stopActionCount, 0)
    }
    
    func test_nextLine_withPalindromeInput() {
        let sut = LineInterpreter()
        var receivedWords = [String]()
        
        sut.processLine("oto")
            .palindrome {
                receivedWords.append($0)
            }
        
        XCTAssertEqual(receivedWords, ["oto"])
    }
    
    func test_nextLine_withStoppingInput() {
        let sut = LineInterpreter()
        var stopActionCount = 0
        
        sut.processLine("Stop!")
            .stop {
                stopActionCount += 1
            }
        
        XCTAssertEqual(stopActionCount, 1)
    }
}
