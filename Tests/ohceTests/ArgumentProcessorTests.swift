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
        let sut = makeSUT(arguments: ["executableName", "firstParameter"])
        
        sut.process()
            .run(validArgument: { argument in
                actionCount += 1
                validArgument = argument
            })
            .handle(invalidArgument: {
                XCTFail("Expected validated argument")
            })
        
        XCTAssertEqual(actionCount, 1)
        XCTAssertEqual(validArgument, "firstParameter")
    }
    
    func test_process_discardsExecutableNameAndInvalidatesMoreThanOneArgument() {
        var actionCount = 0
        let sut = makeSUT(arguments: ["executableName", "firstParameter", "secondParameter"])
        
        sut.process()
            .run(validArgument: { argument in
                XCTFail("Expected invalidated argument, got valid \(argument) instead")
            })
            .handle(invalidArgument: {
                actionCount += 1
            })
        
        XCTAssertEqual(actionCount, 1)
    }
    
    func test_process_discardsExecutableNameAndInvalidatesNoArgument() {
        var actionCount = 0
        let sut = makeSUT(arguments: ["executableName"])
        
        sut.process()
            .run(validArgument: { argument in
                XCTFail("Expected invalidated argument, got valid \(argument) instead")
            })
            .handle(invalidArgument: {
                actionCount += 1
            })
        
        XCTAssertEqual(actionCount, 1)
    }
    
    func test_process_invalidatesNoArgument() {
        var actionCount = 0
        let sut = makeSUT(arguments: [])
        
        sut.process()
            .run(validArgument: { argument in
                XCTFail("Expected invalidated argument, got valid \(argument) instead")
            })
            .handle(invalidArgument: {
                actionCount += 1
            })
        
        XCTAssertEqual(actionCount, 1)
    }
}

private extension ArgumentProcessorTests {
    
    func makeSUT(arguments: [String]) -> ArgumentProcessing {
        let argumentProvider = ArgumentProviderStub(arguments: arguments)
        let sut = ArgumentProcessor(argumentProvider: argumentProvider)
        return sut
    }
    
    final class ArgumentProviderStub: ArgumentProviding {
        let arguments: [String]
        
        init(arguments: [String]) {
            self.arguments = arguments
        }
    }
}
