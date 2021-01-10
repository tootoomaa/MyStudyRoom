import Foundation

class Person: CustomStringConvertible {
    
    var streetAddress = "", postCode = "", city = ""
    
    //employment
    var companyName = "", position = ""
    var annualIncome = 0
    
    
    var description: String {
        return "I live at \(streetAddress), \(postCode), \(city)\n" +
        "I work at \(companyName) as a \(position), earning \(annualIncome)"
    }
}

class PersonBuilder {
    
    var person = Person()
    
    var lives: PersonAddressBuilder {
        return PersonAddressBuilder(person)
    }
    
    var works: PersonJobBuilder {
        return PersonJobBuilder(person)
    }
    
    func build() -> Person {
        return person
    }
}

class PersonJobBuilder: PersonBuilder {
    
    internal init(_ person: Person) {
        super.init()
        self.person = person
    }
    
    func at(_ companyName: String) -> PersonJobBuilder {
        person.companyName = companyName
        return self
    }
    
    func asPosition(_ position: String) -> PersonJobBuilder {
        person.position = position
        return self
    }

    func earning(_ annualIncome: Int) -> PersonJobBuilder {
        person.annualIncome = annualIncome
        return self
    }
    
}

class PersonAddressBuilder: PersonBuilder {
    
    internal init(_ person: Person) {
        super.init()
        self.person = person
    }
    
    func at(_ streetAddress: String) -> PersonAddressBuilder {
        person.streetAddress = streetAddress
        return self
    }
    
    func withPostCode(_ postCode: String) -> PersonAddressBuilder {
        person.postCode = postCode
        return self
    }
    
    func inCity(_ city: String) -> PersonAddressBuilder {
        person.city = city
        return self
    }
}

let pb = PersonBuilder()
let p = pb
    .lives.at("123 Londun Road")
        .inCity("London")
        .withPostCode("SW123BC")
    .works.at("AComplay")
        .asPosition("Engineer")
        .earning(123000)
    .build()

print(p)

