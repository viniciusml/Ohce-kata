//
//  Printer.swift
//  
//
//  Created by Vinicius Leal on 05/04/2023.
//

import Foundation

public protocol Printable {
    func log(_ message: String)
}

public final class Printer: Printable {
    
    public init() {}
    
    public func log(_ message: String) {
        PrintUtil.printClosure(message)
    }
}
