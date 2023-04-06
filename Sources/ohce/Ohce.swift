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
        
        if let argument {
            printer.log("> ¡Buenos días \(argument)!")
        } else {
            printer.log("Error: no argument passed")
            exit(1)
        }
    }
}
