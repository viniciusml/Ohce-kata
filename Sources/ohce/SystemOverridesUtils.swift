//
//  SystemOverridesUtils.swift
//  
//
//  Created by Vinicius Leal on 05/04/2023.
//

import Foundation

public enum ExitUtil {
    
    static var exitClosure: (Int32) -> Never = defaultExitClosure
    
    private static let defaultExitClosure = { Darwin.exit($0) }
    
    public static func replaceExit(closure: @escaping (Int32) -> Never) {
        exitClosure = closure
    }
    
    public static func restoreExit() {
        exitClosure = defaultExitClosure
    }
}
