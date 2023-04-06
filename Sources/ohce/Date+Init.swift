//
//  Date+Init.swift
//  
//
//  Created by Vinicius Leal on 06/04/2023.
//

import Foundation

public extension Date {
    
    init?(hour: Int, minute: Int) {
        let calendar = Calendar(identifier: .gregorian)
        
        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        
        guard let date = calendar.date(from: components) else {
            return nil
        }
        
        self = date
    }
}
