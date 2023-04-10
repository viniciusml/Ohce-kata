//
//  LineProvider.swift
//  
//
//  Created by Vinicius Leal on 10/04/2023.
//

import Foundation

public protocol LineProviding {
    func provide() -> String?
}

public final class LineProvider: LineProviding {
    
    private let printer: Printable
    
    public init(printer: Printable) {
        self.printer = printer
    }
    
    public func provide() -> String? {
        promptLine()
    }
    
    private func promptLine() -> String? {
        printer.log("$", terminator: " ")
        return readLine()
    }
}
