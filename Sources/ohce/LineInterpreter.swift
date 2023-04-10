//
//  LineReader.swift
//  
//
//  Created by Vinicius Leal on 09/04/2023.
//

import Foundation

public protocol LineProviding {
    func readLine() -> String?
}

public final class LineProvider: LineProviding {
    
    public init() {}
    
    public func readLine() -> String? {
        Swift.readLine()
    }
}

public final class LineInterpreter {
    
    private var nextCapturedLine: String? = .none
    
    public init() {}
    
    @discardableResult
    public func processLine(_ line: String) -> Self {
        nextCapturedLine = line
        return self
    }
    
    @discardableResult
    public func reversed(_ word: (String) -> Void) -> Self {
        if let nextCapturedLine {
            word(nextCapturedLine.reversed().toString())
        }
        return self
    }
    
    @discardableResult
    public func palindrome(_ word: (String) -> Void) -> Self {
        if let nextCapturedLine, nextCapturedLine.reversed().toString() == nextCapturedLine {
            word(nextCapturedLine)
        }
        return self
    }
}

private extension Array where Element == Character {
    
    func toString() -> String {
        self.map { String($0) }.joined()
    }
}
