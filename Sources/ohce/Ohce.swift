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
    
    private let exiter: Exitable
    private let date: DateFactory
    private var greeting = ""
    
    public init(exiter: Exitable, date: @escaping DateFactory = { Date() }) {
        self.exiter = exiter
        self.date = date
    }
    
    @discardableResult
    public func run(_ argument: String) -> Self {
        let date = date()
        
        if date.isBetween(.h(06), and: .h(11, 59)) {
            greet(.morning, argument: argument)
        } else if date.isBetween(.h(12), and: .h(20)) {
            greet(.afternoon, argument: argument)
        } else {
            greet(.evening, argument: argument)
        }
        return self
    }
    
    @discardableResult
    public func greet(_ action: (String) -> Void) -> Self {
        action(greeting)
        return self
    }
    
    private func greet(_ greetType: Greet, argument: String) {
        switch greetType {
        case .morning:
            greeting = "> ¡Buenos días \(argument)!"
        case .afternoon:
            greeting = "> ¡Buenas tardes \(argument)!"
        case .evening:
            greeting = "> ¡Buenas noches \(argument)!"
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
