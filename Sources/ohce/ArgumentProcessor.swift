//
//  ArgumentProcessor.swift
//  
//
//  Created by Vinicius Leal on 09/04/2023.
//

import Foundation

public final class ArgumentProcessor {
    private let argumentProvider: ArgumentProviding
    private let onInvalidArgument: () -> Void
    private let onValidArgument: (String) -> Void
    
    public init(argumentProvider: ArgumentProviding = ProcessInfo.processInfo,
                onInvalidArgument: @escaping () -> Void,
                onValidArgument: @escaping (String) -> Void) {
        self.argumentProvider = argumentProvider
        self.onInvalidArgument = onInvalidArgument
        self.onValidArgument = onValidArgument
    }
    
    public func process() {
        let arguments = argumentProvider.arguments.dropFirst()
        
        guard arguments.count == 1, let argument = arguments.first else {
            return onInvalidArgument()
        }
        
        onValidArgument(argument)
    }
}
