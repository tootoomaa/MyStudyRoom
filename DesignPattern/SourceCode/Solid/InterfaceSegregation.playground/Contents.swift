import UIKit

class Document {
    
}

protocol Machine {
    func printDoc(d: Document) throws
    func scanDoc(d: Document) throws
    func faxDoc(d: Document) throws
}

protocol Printer {
    func printDoc(d: Document)
}

protocol Scanner {
    func scanDoc(d: Document)
}

protocol Fax {
    func faxDoc(d: Document)
}

//class MultiFunctionPrinter: Machine {
//    func print(d: Document) {
//
//    }
//}

enum NoRequiredFunctionality: Error {
    case doseNotPrint
    case doseNotScan
    case doseNotFax
}

//class OldFashionedPrinter: Machine {
//    func print(d: Document) {
//        // ok
//    }
//
//    func fax(d: Document) {
//        throw NoRequiredFunctionality.doseNotFax
//    }
//
//}

class PhotoCopier: Machine {
    func printDoc(d: Document) {
        print("print Document")
    }
    
    func scanDoc(d: Document) {
        print("Scan Document")
    }
    
    func faxDoc(d: Document) throws {
        throw NoRequiredFunctionality.doseNotFax
    }
}

//class PhotoCopier: Printer, Scanner {
//
//    func printDoc(d: Document) {
//        // ok
//    }
//
//    func scanDoc(d: Document) {
//        // ok
//    }
//}


protocol MultiFunctionDevice: Printer, Scanner, Fax {

}

class MultiFunctionMachine: MultiFunctionDevice {
    
    let printer: Printer
    let scanner: Scanner
    
    init(printer: Printer, scanner: Scanner) {
        self.printer = printer
        self.scanner = scanner
    }
    
    func printDoc(d: Document) {
        printer.printDoc(d: d)
    }
}


class PrintMachine: Printer {
    func printDoc(d: Document) {
        print("print Document")
    }
}

let printMachine = PrintMachine()

printMachine.printDoc(d: Document())

//do {
//    try printMachine.faxDoc(d: Document())
//} catch {
//    print("\(error) : This Function isn't supported")
//}
//
//do {
//    try printMachine.scanDoc(d: Document())
//} catch {
//    print("\(error) : This Function isn't supported")
//}

