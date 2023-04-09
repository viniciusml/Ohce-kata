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
        var actionCount = 0
        let sut = makeSUT(
            arguments: ["executableName", "firstParameter"],
            invalidAction: {
                XCTFail("Expected validated argument")
            },
            validAction: {
                actionCount += 1
            })
        
        sut.process()
        
        XCTAssertEqual(actionCount, 1)
    }
    
    func test_process_discardsExecutableNameAndInvalidatesMoreThanOneArgument() {
        var actionCount = 0
        let sut = makeSUT(
            arguments: ["executableName", "firstParameter", "secondParameter"],
            invalidAction: {
                actionCount += 1
            },
            validAction: {
                XCTFail("Expected invalidated argument")
            })
        
        sut.process()
        
        XCTAssertEqual(actionCount, 1)
    }
}

private extension ArgumentProcessorTests {
    
    func makeSUT(arguments: [String],
                 invalidAction: @escaping () -> Void,
                 validAction: @escaping () -> Void
    ) -> ArgumentProcessor {
        let argumentProvider = ArgumentProviderStub(arguments: arguments)
        let sut = ArgumentProcessor(argumentProvider: argumentProvider, onInvalidArgument: invalidAction, onValidArgument: validAction)
        return sut
    }
    
    final class ArgumentProviderStub: ArgumentProviding {
        let arguments: [String]
        
        init(arguments: [String]) {
            self.arguments = arguments
        }
    }
}
