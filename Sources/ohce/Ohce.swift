//
//  Ohce.swift
//  
//
//  Created by Vinicius Leal on 05/04/2023.
//

import Foundation

public final class Ohce {
    public typealias DateFactory = () -> Date
    
    private let printer: Printable
    private let date: DateFactory
    
    public init(printer: Printable, date: @escaping DateFactory = { Date() }) {
        self.printer = printer
        self.date = date
    }
    
    public func run(_ argument: String?) {
        
        if let argument {
            if date() >= Date(hour: 12, minute: 00)! {
                printer.log("> ¡Buenas tardes \(argument)!")
            } else {
                printer.log("> ¡Buenos días \(argument)!")
            }
        } else {
            printer.log("Error: no argument passed")
            exit(1)
        }
    }
}

private extension Date {
    
    init?(hour: Int, minute: Int) {
        let calendar = Calendar(identifier: .gregorian)
        
        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        
        guard let date = calendar.date(from: components) else {
            return nil
        }
        
        self = date
    }
}
