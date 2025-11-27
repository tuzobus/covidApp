//
//  CovidRepository.swift
//  covidApp
//
//  Created by Iván FV on 27/11/25.
//

import Foundation

struct Api {
    static let base = "https://api.api-ninjas.com/v1"
    
    struct routes {
        static let covid19 = "/covid19"
    }
}

protocol CovidAPIProtocol {
    func getCovidByCountry(country: String) async -> [CovidApiLocation]?
}

class CovidRepository: CovidAPIProtocol {
    static let shared = CovidRepository()
    
    let nservice: NetworkAPIService
    
    init(nservice: NetworkAPIService = NetworkAPIService.shared) {
        self.nservice = nservice
    }
    
    func getCovidByCountry(country: String) async -> [CovidApiLocation]? {
        await nservice.getCountryData(country: country)
    }
}
