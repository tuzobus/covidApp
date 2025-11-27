//
//  CountryPreferenceRequirement.swift
//  covidApp
//
//  Created by Iván FV on 27/11/25.
//

import Foundation

protocol CountryPreferenceRequirementProtocol {
    func getLastCountry() -> String?
    func setLastCountry(country: String)
    func clearLastCountry()
}

class CountryPreferenceRequirement: CountryPreferenceRequirementProtocol {
    static let shared = CountryPreferenceRequirement()
    
    let dataRepository: PreferencesRepository
    
    init(dataRepository: PreferencesRepository = PreferencesRepository.shared) {
        self.dataRepository = dataRepository
    }
    
    func getLastCountry() -> String? {
        return dataRepository.getLastCountry()
    }
    
    func setLastCountry(country: String) {
        dataRepository.setLastCountry(country: country)
    }
    
    func clearLastCountry() {
        dataRepository.clearLastCountry()
    }
}
