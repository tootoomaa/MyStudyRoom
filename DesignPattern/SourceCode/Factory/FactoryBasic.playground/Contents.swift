import UIKit

class Point: CustomStringConvertible {

    var x, y: Double

    private init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    //
    private init(rho: Double, theta: Double) { // initializer 에 이름을 줄 수 없다.
        self.x = rho * cos(theta)
        self.y = rho * cos(theta)
    }

    var description: String {
        return "x = \(x), y = \(y)"
    }

    static let factory = PointFactory.instance

    class PointFactory {

        private init() {}

        static let instance = PointFactory()

        func createCartesian(x:Double, y:Double) -> Point {

            return Point(x: x, y: y)

        }

        func createPolar(rho:Double, theta: Double) -> Point {

            return Point(rho: rho, theta: theta)

        }
    }
}

let pf = Point.factory.createCartesian(x: 1, y: 1)
