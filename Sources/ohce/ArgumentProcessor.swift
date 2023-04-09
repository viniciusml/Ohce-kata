//
//  ArgumentProcessor.swift
//  
//
//  Created by Vinicius Leal on 09/04/2023.
//

import Foundation

public protocol ArgumentProcessing {
    @discardableResult
    func process() -> ArgumentProcessing
    
    @discardableResult
    func run(validArgument: (String) -> Void) -> ArgumentProcessing
    
    @discardableResult
    func handle(invalidArgument: () -> Void) -> ArgumentProcessing
}

public final class ArgumentProcessor: ArgumentProcessing {
    enum Error: Swift.Error {
        case notYetProcessed
        case invalidArgument
    }
    
    private let argumentProvider: ArgumentProviding
    private var result: Result<String, Error> = .failure(.notYetProcessed)
    
    public init(argumentProvider: ArgumentProviding = ProcessInfo.processInfo) {
        self.argumentProvider = argumentProvider
    }
    
    @discardableResult
    public func process() -> ArgumentProcessing {
        let arguments = argumentProvider.arguments.dropFirst()
        
        guard arguments.count == 1, let argument = arguments.first else {
            result = .failure(.invalidArgument)
            return self
        }
        
        result = .success(argument)
        return self
    }
    
    @discardableResult
    public func run(validArgument: (String) -> Void) -> ArgumentProcessing {
        guard case let .success(argument) = result else {
            return self
        }
        validArgument(argument)
        return self
    }
    
    @discardableResult
    public func handle(invalidArgument: () -> Void) -> ArgumentProcessing {
        guard case .failure = result else {
            return self
        }
        invalidArgument()
        return self
    }
}
