import UIKit

protocol CopyByInitializer {
    init(copyForm other: Self)
}

class Address: CustomStringConvertible, CopyByInitializer {
    var streetAddress: String
    var city: String
    
    init(_ streetAddress: String, _ city: String) {
        self.streetAddress = streetAddress
        self.city = city
    }
    
    required init(copyForm other: Address) {
        self.streetAddress = other.streetAddress
        self.city = other.city
    }
    
    var description: String {
        return "\(streetAddress), \(city)"
    }

}


class Employee: CustomStringConvertible, CopyByInitializer {
    
    var name: String
    var address: Address
    
    init(_ name: String, _ address: Address) {
        self.name = name
        self.address = address
    }
    
    required init(copyForm other: Employee) {
        self.name = other.name
        
        // option 1
//        address = Address(other.address.streetAddress,
//                          other.address.city)
        
        // oprion 2
        address = Address(copyForm: other.address)
    }
    
    var description: String {
        return "My name is \(name) and I live at \(address)"
    }
    
}

let kim = Employee("Kim", Address("London 142", "London"))
//let park = Employee("Park", Address("Paris 155", "Paris"))

var park = Employee(copyForm: kim)
park.name = "Park"
park.address = Address("Paris 155", "Paris")

print(kim)
print(park)


