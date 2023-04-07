//
//  Ohce.swift
//  
//
//  Created by Vinicius Leal on 05/04/2023.
//

import Foundation

public final class Ohce {
    public typealias DateFactory = () -> Date
    
    enum Greet {
        case morning
        case afternoon
        case evening
    }
    
    private let printer: Printable
    private let date: DateFactory
    
    public init(printer: Printable, date: @escaping DateFactory = { Date() }) {
        self.printer = printer
        self.date = date
    }
    
    public func run(_ argument: String?) {
        let date = date()
        
        guard let argument else {
            printer.log("Error: no argument passed")
            exit(1)
        }
        
        if date.isBetween(.h(06), and: .h(11, 59)) {
            greet(.morning, argument: argument)
        } else if date.isBetween(.h(12), and: .h(20)) {
            greet(.afternoon, argument: argument)
        } else {
            greet(.evening, argument: argument)
        }
    }
    
    private func greet(_ greetType: Greet, argument: String) {
        switch greetType {
        case .morning:
            printer.log("> ¡Buenos días \(argument)!")
        case .afternoon:
            printer.log("> ¡Buenas tardes \(argument)!")
        case .evening:
            printer.log("> ¡Buenas noches \(argument)!")
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
