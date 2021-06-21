//
//  DisplayNumberInspactor.swift
//  CleanArchitectureExample
//
//  Created by 김광수 on 2021/06/06.
//

import Foundation

protocol DisplayNumberInspactor {
    func addNumber()
    func minusNumber()
}


// MARK: - Implementation

struct RealDisplayNumberInspactor: DisplayNumberInspactor {
    
    let appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func addNumber() {
        appState.displayNumder.number += 1
    }
    
    func minusNumber() {
        appState.displayNumder.number -= 1
    }
    
}

struct StubDisplayNumberInspactor: DisplayNumberInspactor {
    func addNumber() {
        print("plus +1")
    }
    
    func minusNumber() {
        print("minus -1 ")
    }
}


/*

protocol CountriesInteractor {
    func loadCountries()
    func load(countryDetails: Binding<Loadable<Country.Details>>, country: Country)
}

// MARK: - Implementation

struct RealCountriesInteractor: CountriesInteractor {
    let webRepository: CountriesWebRepository
    let appState: AppState

    init(webRepository: CountriesWebRepository, appState: AppState) {
        self.webRepository = webRepository
        self.appState = appState
    }

    func loadCountries() {
        appState.userData.countries = .isLoading(last: appState.userData.countries.value)
        weak var weakAppState = appState
        _ = webRepository.loadCountries()
            .sinkToLoadable { weakAppState?.userData.countries = $0 }
    }

    func load(countryDetails: Binding<Loadable<Country.Details>>, country: Country) {
        countryDetails.wrappedValue = .isLoading(last: countryDetails.wrappedValue.value)
        _ = webRepository.loadCountryDetails(country: country)
            .sinkToLoadable { countryDetails.wrappedValue = $0 }
    }
}
*/
