//
//  Exiter.swift
//  
//
//  Created by Vinicius Leal on 08/04/2023.
//

import Foundation

public protocol Exitable {
    func exit(_ code: Int32)
}

public final class Exiter: Exitable {
    
    public init() {}
    
    public func exit(_ code: Int32) {
        ExitUtil.exitClosure(code)
    }
}
