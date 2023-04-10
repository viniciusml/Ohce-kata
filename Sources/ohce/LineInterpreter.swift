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
        guard let nextCapturedLine else {
            return self
        }
        executeFor(
            nextCapturedLine.compared(stopKeyword, !=) && nextCapturedLine.asReversedString.compared(nextCapturedLine, !=),
            action: {
                word(nextCapturedLine.asReversedString)
            })
        return self
    }
    
    @discardableResult
    public func palindrome(_ word: (String) -> Void) -> Self {
        guard let nextCapturedLine else {
            return self
        }
        executeFor(
            nextCapturedLine.asReversedString.compared(nextCapturedLine, ==),
            action: {
                word(nextCapturedLine)
            })
        return self
    }
    
    @discardableResult
    public func stop(_ action: () -> Void) -> Self {
        guard let nextCapturedLine else {
            return self
        }
        executeFor(
            nextCapturedLine.compared(stopKeyword, ==),
            action: {
                action()
            })
        return self
    }
    
    private func executeFor(_ condition: Bool, action: () -> Void) {
        if condition {
            resetCapturedLine()
            action()
        }
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
