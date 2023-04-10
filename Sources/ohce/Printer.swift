//
//  Printer.swift
//  
//
//  Created by Vinicius Leal on 05/04/2023.
//

import Foundation

public protocol Printable {
    func log(_ message: String, terminator: String)
}

public extension Printable {
    func log(_ message: String) {
        log(message, terminator: "\n")
    }
}

public final class Printer: Printable {
    
    public init() {}
    
    public func log(_ message: String, terminator: String) {
        PrintUtil.printClosure(message, terminator)
    }
}
