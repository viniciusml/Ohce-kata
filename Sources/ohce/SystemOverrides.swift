//
//  SystemOverrides.swift
//  
//
//  Created by Vinicius Leal on 05/04/2023.
//

import Foundation

public func exit(_ code: Int32) -> Never {
    ExitUtil.exitClosure(code)
}

public func print(_ message: String) {
    PrintUtil.printClosure(message)
}
