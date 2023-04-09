//
//  ArgumentProcessor.swift
//  
//
//  Created by Vinicius Leal on 09/04/2023.
//

import Foundation

public protocol ArgumentProviding {
    var arguments: [String] { get }
}

extension ProcessInfo: ArgumentProviding {}

public final class ArgumentProcessor {
    public typealias Action = () -> Void
    
    private let argumentProvider: ArgumentProviding
    private let onInvalidArgument: Action
    private let onValidArgument: Action
    
    public init(argumentProvider: ArgumentProviding = ProcessInfo.processInfo,
                onInvalidArgument: @escaping Action,
                onValidArgument: @escaping Action) {
        self.argumentProvider = argumentProvider
        self.onInvalidArgument = onInvalidArgument
        self.onValidArgument = onValidArgument
    }
    
    public func process() {
        let arguments = argumentProvider.arguments.dropFirst()
        
        guard arguments.count == 1 else {
            return onInvalidArgument()
        }
        
        onValidArgument()
    }
}
