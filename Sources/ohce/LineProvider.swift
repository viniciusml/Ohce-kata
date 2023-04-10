//
//  LineProvider.swift
//  
//
//  Created by Vinicius Leal on 10/04/2023.
//

import Foundation

public protocol LineProviding {
    func provide() -> String?
}

public final class LineProvider: LineProviding {
    
    public init() {}
    
    public func provide() -> String? {
        Swift.readLine()
    }
}
