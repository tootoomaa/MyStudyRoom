import Foundation

protocol Copying {
    associatedtype T
    func clone() -> T
}


class Address: CustomStringConvertible, Copying {
    var streetAddress: String
    var city: String
    
    init(_ streetAddress: String, _ city: String) {
        self.streetAddress = streetAddress
        self.city = city
    }
    
    var description: String {
        return "\(streetAddress), \(city)"
    }
    
    func clone() -> Address {
        return Address(streetAddress, city)
    }
}

class Employee: CustomStringConvertible, Copying {
    var name: String
    var address: Address
    
    init(_ name: String, _ address: Address) {
        self.name = name
        self.address = address
    }
    
    var description: String {
        return "My name is \(name) and i live at \(address)"
    }
    
    func clone() -> Employee { // <-- Struct
        return Employee(name, address.clone())
    }
}


var kim = Employee("Kim", Address("London 142", "London"))

var park = kim.clone()

park.name = "Park"
park.address.streetAddress = "Paris 155"
park.address.city = "Paris"

print(kim)
print(park)

