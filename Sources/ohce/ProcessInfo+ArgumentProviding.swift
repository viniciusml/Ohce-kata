//
//  ProcessInfo+ArgumentProviding.swift
//  
//
//  Created by Vinicius Leal on 09/04/2023.
//

import Foundation

public protocol ArgumentProviding {
    var arguments: [String] { get }
}

extension ProcessInfo: ArgumentProviding {}
