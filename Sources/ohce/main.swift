import Foundation

public class Ohce {
    
    public init() {}
    
    public func run(_ argument: String?) {
        
        if argument == nil {
            exit(1)
        }
    }
}

let app = Ohce()
app.run(nil)

public func exit(_ code: Int32) -> Never {
    ExitUtil.exitClosure(code)
}

public struct ExitUtil {
    
    static var exitClosure: (Int32) -> Never = defaultExitClosure
    
    private static let defaultExitClosure = { Darwin.exit($0) }
    
    public static func replaceExit(closure: @escaping (Int32) -> Never) {
        exitClosure = closure
    }
    
    public static func restoreExit() {
        exitClosure = defaultExitClosure
    }
}
