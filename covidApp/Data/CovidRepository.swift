//
//  CovidRepository.swift
//  covidApp
//
//  Created by Iván FV on 27/11/25.
//

import Foundation

protocol CovidAPIProtocol {
    func getCovidByCountry(country: String) async -> [CovidApiLocation]?
    
    func getGlobalSnapshot(date: String) async -> [CovidApiLocation]?
}

class CovidRepository: CovidAPIProtocol {
    static let shared = CovidRepository()
    
    let nservice: NetworkAPIService
    
    init(nservice: NetworkAPIService = NetworkAPIService.shared) {
        self.nservice = nservice
    }
    
    func getCovidByCountry(country: String) async -> [CovidApiLocation]? {
        await nservice.getCovidByCountry(country: country)
    }
    
    func getGlobalSnapshot(date: String) async -> [CovidApiLocation]? {
        await nservice.getGlobalSnapshot(date: date)
    }
}
