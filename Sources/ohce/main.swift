import Foundation

let printer = Printer()
let exiter = Exiter()
let app = Ohce(printer: printer, exiter: exiter)

let argumentProcessor = ArgumentProcessor()
argumentProcessor
    .process()
    .run(validArgument: app.run)
    .handle(invalidArgument: {
        printer.log("Error: no argument passed")
        exiter.exit(1)
    })
