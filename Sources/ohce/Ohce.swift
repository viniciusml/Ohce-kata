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
            if date.isBetween(.h(06), and: .h(11, 59)) {
                printer.log("> ¡Buenos días \(argument)!")
            } else if date.isBetween(.h(12), and: .h(20)) {
                printer.log("> ¡Buenas tardes \(argument)!")
            } else {
                printer.log("> ¡Buenas noches \(argument)!")
            }
        } else {
            printer.log("Error: no argument passed")
            exit(1)
        }
    }
}

private extension Date {
    
    func isBetween(_ lhs: Date?, and rhs: Date?) -> Bool {
        guard let lhs = lhs, let rhs = rhs else {
            return false
        }
        return (min(lhs, rhs)...max(lhs, rhs)).contains(self)
    }
    
    static func h(_ hour: Int, _ minute: Int = 00) -> Self? {
        Date(hour: hour, minute: minute)
    }
}
