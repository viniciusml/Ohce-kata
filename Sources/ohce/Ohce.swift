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
        let date = date()
        
        if let argument {
            if date.isBetween(.h(12), and: .h(20)) {
                printer.log("> ¡Buenas tardes \(argument)!")
            } else if date >= Date(hour: 20, minute: 00)! {
                printer.log("> ¡Buenas noches \(argument)!")
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
    
    func isBetween(_ value1: Date?, and value2: Date?) -> Bool {
        guard let value1 = value1, let value2 = value2 else {
            return false
        }
        return self >= value1 && self < value2
    }
    
    static func h(_ hour: Int, _ minute: Int = 00) -> Self? {
        Date(hour: hour, minute: minute)
    }
}
