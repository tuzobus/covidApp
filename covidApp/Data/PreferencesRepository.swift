//
//  PreferencesRepository.swift
//  covidApp
//
//  Created by Iván FV on 27/11/25.
//

import Foundation

protocol PreferencesServiceProtocol {
    func getLastCountry() -> String?
    func setLastCountry(country: String)
    func clearLastCountry()
}

protocol PreferencesServiceProtocol {
    func getLastCountry() -> String?
    func setLastCountry(country: String)
    func clearLastCountry()
}

class PreferencesRepository: PreferencesServiceProtocol {
    static let shared = PreferencesRepository()
    
    private let localService: LocalService
    
    init(localService: LocalService = LocalService.shared) {
        self.localService = localService
    }
    
    func getLastCountry() -> String? {
        localService.getLastCountry()
    }
    
    func setLastCountry(country: String) {
        localService.setLastCountry(country: country)
    }
    
    func clearLastCountry() {
        localService.removeLastCountry()
    }
}
