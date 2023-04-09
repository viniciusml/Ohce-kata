import Foundation

let printer = Printer()
let exiter = Exiter()
let app = Ohce(printer: printer, exiter: exiter)

let argumentProcessor = ArgumentProcessor(
    onInvalidArgument: {
        // TODO: move error handling
    },
    onValidArgument: { argument in
        app.run(argument)
    }
)

argumentProcessor.process()
