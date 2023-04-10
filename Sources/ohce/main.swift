import Foundation

let printer = Printer()
let exiter = Exiter()

let argumentProcessor = ArgumentProcessor()
argumentProcessor
    .process()
    .run(validArgument: { argument in
        Ohce()
            .run(argument)
            .greet(printer.log)
    })
    .handle(invalidArgument: {
        printer.log("Error: no argument passed")
        exiter.exit(1)
    })
