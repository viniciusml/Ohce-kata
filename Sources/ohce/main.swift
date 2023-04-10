import Foundation

let printer = Printer()
let exiter = Exiter()
let greeter = Greeter()
let lineProvider = LineProvider(printer: printer)
let lineInterpreter = LineInterpreter()

let argumentProcessor = ArgumentProcessor()
argumentProcessor
    .process()
    .run(validArgument: { argument in
        greeter
            .run(argument)
            .greet(printer.log)
            .and {
                while let line = lineProvider.provide() {
                    lineInterpreter.processLine(line)
                        .reversed { reversed in
                            printer.log("> \(reversed)")
                        }
                        .palindrome { palindrome in
                            printer.log("> \(palindrome)")
                            printer.log("> ¡Bonita palabra!")
                        }
                        .stop {
                            greeter.sayGoodbye(printer.log)
                            exiter.exit(0)
                        }
                }
            }
    })
    .handle(invalidArgument: {
        printer.log("Error: no argument passed")
        exiter.exit(1)
    })
