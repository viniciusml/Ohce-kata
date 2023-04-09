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
        var validArgument = ""
        let sut = makeSUT(
            arguments: ["executableName", "firstParameter"],
            invalidAction: {
                XCTFail("Expected validated argument")
            },
            validAction: { argument in
                actionCount += 1
                validArgument = argument
            })
        
        sut.process()
        
        XCTAssertEqual(actionCount, 1)
        XCTAssertEqual(validArgument, "firstParameter")
    }
    
    func test_process_discardsExecutableNameAndInvalidatesMoreThanOneArgument() {
        var actionCount = 0
        let sut = makeSUT(
            arguments: ["executableName", "firstParameter", "secondParameter"],
            invalidAction: {
                actionCount += 1
            },
            validAction: { argument in
                XCTFail("Expected invalidated argument, got valid \(argument) instead")
            })
        
        sut.process()
        
        XCTAssertEqual(actionCount, 1)
    }
    
    func test_process_discardsExecutableNameAndInvalidatesNoArgument() {
        var actionCount = 0
        let sut = makeSUT(
            arguments: ["executableName"],
            invalidAction: {
                actionCount += 1
            },
            validAction: { argument in
                XCTFail("Expected invalidated argument, got valid \(argument) instead")
            })
        
        sut.process()
        
        XCTAssertEqual(actionCount, 1)
    }
    
    func test_process_invalidatesNoArgument() {
        var actionCount = 0
        let sut = makeSUT(
            arguments: [],
            invalidAction: {
                actionCount += 1
            },
            validAction: { argument in
                XCTFail("Expected invalidated argument, got valid \(argument) instead")
            })
        
        sut.process()
        
        XCTAssertEqual(actionCount, 1)
    }
}

private extension ArgumentProcessorTests {
    
    func makeSUT(arguments: [String],
                 invalidAction: @escaping () -> Void,
                 validAction: @escaping (String) -> Void
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
