//
//  ContentView.swift
//  FormattingSwiftUI
//
//  Created by 김광수 on 2022/03/18.
//

import SwiftUI


extension Decimal {
    
    func formatAsCurrency(_ locale: Locale = Locale.current) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        return formatter.string(from: NSDecimalNumber(decimal: self)) ?? formatter.string(from: NSNumber(value: 0))!
    }
}

extension Double {
    
    func convert(from: UnitLength, to: UnitLength) -> Measurement<UnitLength> {
        let measurement = Measurement(value: self, unit: from)
        return measurement.converted(to: to)
    }
    
}

extension Measurement {
    func format() -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        return formatter.string(from: self)
    }
}

struct ContentView: View {
    
    let now = Date()
    let amount: Decimal = 45.56
    @Environment(\.locale) var locale
    let distance: Double = 100.0
    
    let people = ["Alex", "John", "Steven", "Mary"]
    
    var body: some View {
        
        VStack(spacing: 5) {
            
            Text(amount.formatAsCurrency())
            Text(amount.formatAsCurrency(Locale(identifier: "ko_KR")))
            
            Text(distance.convert(from: .meters, to: .feet).formatted())
            
            Text(distance.convert(from: .feet, to: .miles).formatted())
            
            Text(people, format: .list(type: .or))
            Text(people, format: .list(type: .and))
            
            /* about Date
            Text(now.formatted())
            Text(now.formatted(date: .omitted, time: .standard))
            Text(now.formatted(date: .abbreviated, time: .complete))
            Text(now.formatted(date: .long, time: .omitted))
            Text(now.formatted(date: .numeric, time: .omitted))
            Text(now.formatted(.iso8601))
            
            Text(now, format: Date.FormatStyle().day())
            Text(now, format: Date.FormatStyle().month())
            Text(now, format: Date.FormatStyle().day().month(.twoDigits))
//            Text(now, format: Date.FormatStyle().day().month().year())
            Text(now, format: Date.FormatStyle().day().year().month())
             */
            
//            Text(now, format: Date.FormatStyle().day(.ordinalOfDayInMonth))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
            .padding()
        
        ContentView()
            .environment(\.locale, .init(identifier: "fr-FR"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
