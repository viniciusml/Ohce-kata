//
//  Ohce.swift
//  
//
//  Created by Vinicius Leal on 05/04/2023.
//

import Foundation

public final class Greeter {
    public typealias DateFactory = () -> Date
    
    enum Greet {
        case morning
        case afternoon
        case evening
    }
    
    private let date: DateFactory
    private var greeting = ""
    
    public init(date: @escaping DateFactory = { Date() }) {
        self.date = date
    }
    
    @discardableResult
    public func run(_ argument: String) -> Self {
        
        let hour = Calendar.current.component(.hour, from: date())
        
        switch hour {
        case 6..<12: greet(.morning, argument: argument)
        case 12..<20: greet(.afternoon, argument: argument)
        default: greet(.evening, argument: argument)
        }
        
        return self
    }
    
    @discardableResult
    public func greet(_ action: (String) -> Void) -> Self {
        action(greeting)
        return self
    }
    
    @discardableResult
    public func and(_ action: () -> Void) -> Self {
        action()
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
