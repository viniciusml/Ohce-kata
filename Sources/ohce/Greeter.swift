//
//  Ohce.swift
//  
//
//  Created by Vinicius Leal on 05/04/2023.
//

import Foundation

public protocol Greeting {
    @discardableResult func run(_ argument: String) -> Self
    @discardableResult func greet(_ action: (String) -> Void) -> Self
    @discardableResult func and(_ action: () -> Void) -> Self
    func sayGoodbye(_ action: (String) -> Void)
}

public final class Greeter: Greeting {
    public typealias DateFactory = () -> Date
    
    enum Greet {
        case morning
        case afternoon
        case evening
    }
    
    private let date: DateFactory
    private var argument: String?
    private var greet: Greet?
    
    public init(date: @escaping DateFactory = { Date() }) {
        self.date = date
    }
    
    @discardableResult
    public func run(_ argument: String) -> Self {
        self.argument = argument
        
        let hour = Calendar.current.component(.hour, from: date())
        
        switch hour {
        case 6..<12: greet = .morning
        case 12..<20: greet = .afternoon
        default: greet = .evening
        }
        
        return self
    }
    
    @discardableResult
    public func greet(_ action: (String) -> Void) -> Self {
        guard let argument, let greet else { return self }
        action(say(greet, argument))
        return self
    }
    
    public func sayGoodbye(_ action: (String) -> Void) {
        guard let argument else { return }
        action("> Adios \(argument)")
    }
    
    @discardableResult
    public func and(_ action: () -> Void) -> Self {
        action()
        return self
    }
    
    private func say(_ greetType: Greet, _ argument: String) -> String {
        switch greetType {
        case .morning:
            return "> ¡Buenos días \(argument)!"
        case .afternoon:
            return "> ¡Buenas tardes \(argument)!"
        case .evening:
            return "> ¡Buenas noches \(argument)!"
        }
    }
}
