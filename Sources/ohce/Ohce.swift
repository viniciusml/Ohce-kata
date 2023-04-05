//
//  Ohce.swift
//  
//
//  Created by Vinicius Leal on 05/04/2023.
//

import Foundation

public final class Ohce {
    
    private let printer: Printable
    
    public init(printer: Printable) {
        self.printer = printer
    }
    
    public func run(_ argument: String?) {
        
        if argument == nil {
            printer.log("Error: no argument passed")
            exit(1)
        }
    }
}

public protocol Printable {
    func log(_ message: String)
}

public final class Printer: Printable {
    
    public func log(_ message: String) {
        Swift.print(message)
    }
}
