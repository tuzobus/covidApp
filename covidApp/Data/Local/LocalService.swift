//
//  LocalService.swift
//  covidApp
//
//  Created by Iván FV on 27/11/25.
//

import Foundation
import Alamofire

class LocalService {
    static let shared = LocalService()
    
    private let lastCountryKey = "lastCountry"
    
    func getLastCountry() -> String? {
        UserDefaults.standard.string(forKey: lastCountryKey)
    }
    
    func setLastCountry(country: String) {
        UserDefaults.standard.set(country, forKey: lastCountryKey)
    }
        
    func removeLastCountry() {
        UserDefaults.standard.removeObject(forKey: lastCountryKey)
    }
}
