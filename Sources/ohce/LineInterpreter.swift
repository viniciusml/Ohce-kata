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
    
    private let stopKeyword = "Stop!"
    private var nextCapturedLine: String? = .none
    
    public init() {}
    
    @discardableResult
    public func processLine(_ line: String) -> Self {
        nextCapturedLine = line
        return self
    }
    
    @discardableResult
    public func reversed(_ word: (String) -> Void) -> Self {
        if let nextCapturedLine, nextCapturedLine.compared(stopKeyword, !=), nextCapturedLine.asReversedString.compared(nextCapturedLine, !=) {
            resetCapturedLine()
            word(nextCapturedLine.asReversedString)
        }
        return self
    }
    
    @discardableResult
    public func palindrome(_ word: (String) -> Void) -> Self {
        if let nextCapturedLine, nextCapturedLine.asReversedString.compared(nextCapturedLine, ==) {
            resetCapturedLine()
            word(nextCapturedLine)
        }
        return self
    }
    
    @discardableResult
    public func stop(_ action: () -> Void) -> Self {
        if nextCapturedLine.compared(stopKeyword, ==) {
            resetCapturedLine()
            action()
        }
        return self
    }
    
    private func resetCapturedLine() {
        nextCapturedLine = nil
    }
}

private extension Array where Element == Character {
    
    func toString() -> String {
        self.map { String($0) }.joined()
    }
}

private extension String {
    
    var asReversedString: String {
        self.reversed().toString()
    }
    
    func compared(_ value: String, _ action: (Self, Self) -> Bool) -> Bool {
        action(value, self)
    }
}

private extension Optional where Wrapped == String {
    
    func compared(_ value: String, _ action: (Self, Self) -> Bool) -> Bool {
        guard let self else {
            return false
        }
        return self.compared(value, action)
    }
}
