import SwiftUI

private struct MyEnvironmentKey: EnvironmentKey {
    typealias Value = String
    
    static let defaultValue: Value = "Default value"
}

extension EnvironmentValues {
    var myCustonValue: String {
        get { self[MyEnvironmentKey.self] }
        set { self[MyEnvironmentKey.self] = newValue }
    }
}

extension View {
    func myCustomValue(_ myCustomValue: String) -> some View {
        environment(\.myCustonValue, myCustomValue)
    }
}


struct MyView: View {
    @Environment(\.myCustomValue) var customValue: String
    
    var body: some View {
        Text(customValue) // Displays "Another value"
    }
}

MyView()
    .myCustomValue("Another String")
