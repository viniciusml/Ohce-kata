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
        let sut = makeSUT()
        
        assertProcessedLine("hola", on: sut, is: .reversed("aloh"))
    }
    
    func test_nextLine_withPalindromeInput() {
        let sut = makeSUT()
        
        assertProcessedLine("oto", on: sut, is: .palindrome)
    }
    
    func test_nextLine_withStoppingInput() {
        let sut = makeSUT()

        assertProcessedLine("Stop!", on: sut, is: .stop)
    }
}

private extension LineInterpreterTests {
    
    enum LineType {
        case reversed(String)
        case palindrome
        case stop
    }
    
    func makeSUT() -> LineInterpreter {
        LineInterpreter()
    }
    
    func assertProcessedLine(_ lineInput: String, on sut: LineInterpreter, is lineType: LineType, file: StaticString = #filePath, line: UInt = #line) {
        var receivedWords = [String]()
        var receivedPalindromes = [String]()
        var stopActionCount = 0
        
        sut.processLine(lineInput)
            .reversed {
                receivedWords.append($0)
            }
            .palindrome {
                receivedPalindromes.append($0)
            }
            .stop {
                stopActionCount += 1
            }
        
        switch (lineType, receivedWords, receivedPalindromes, stopActionCount) {
        case (.reversed(let reversedValue), let words, let palindromes, let stopCount):
            XCTAssertEqual(words, [reversedValue], file: file, line: line)
            XCTAssertEqual(palindromes, [], file: file, line: line)
            XCTAssertEqual(stopCount, 0, file: file, line: line)
        case (.palindrome, let words, let palindromes, let stopCount):
            XCTAssertEqual(words, [], file: file, line: line)
            XCTAssertEqual(palindromes, [lineInput], file: file, line: line)
            XCTAssertEqual(stopCount, 0, file: file, line: line)
        case (.stop, let words, let palindromes, let stopCount):
            XCTAssertEqual(words, [], file: file, line: line)
            XCTAssertEqual(palindromes, [], file: file, line: line)
            XCTAssertEqual(stopCount, 1, file: file, line: line)
        }
    }
}
