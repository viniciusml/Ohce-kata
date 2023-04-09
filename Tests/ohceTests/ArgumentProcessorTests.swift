//
//  ArgumentProcessorTests.swift
//  
//
//  Created by Vinicius Leal on 09/04/2023.
//

import ohce
import XCTest

final class ArgumentProcessorTests: XCTestCase {
    
    func test_process_discardsExecutableNameAndValidatesOneArgument() {
        let argumentProvider = ArgumentProviderStub(arguments: ["executableName", "firstParameter"])
        var actionCount = 0
        let sut = ArgumentProcessor(argumentProvider: argumentProvider, onInvalidArgument: {
            XCTFail("Expected valid argument, received invalid instead")
        }, onValidArgument: {
            actionCount += 1
        })
        
        sut.process()
        
        XCTAssertEqual(actionCount, 1)
    }
}

private extension ArgumentProcessorTests {
    
    final class ArgumentProviderStub: ArgumentProviding {
        let arguments: [String]
        
        init(arguments: [String]) {
            self.arguments = arguments
        }
    }
}
