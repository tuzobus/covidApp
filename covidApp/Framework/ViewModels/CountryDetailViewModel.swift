//
//  CountryDetailViewModel.swift
//  covidApp
//
//  Created by Iván FV on 27/11/25.
//
import Foundation
import Combine

protocol CountryDetailRequirementProtocol {
    func getCountryData(country: String) async -> [CovidApiLocation]?
}

class CountryDetailRequirement: CountryDetailRequirementProtocol {
    static let shared = CountryDetailRequirement()
    
    let dataRepository: CovidRepository
    
    init(dataRepository: CovidRepository = CovidRepository.shared) {
        self.dataRepository = dataRepository
    }
    
    func getCountryData(country: String) async -> [CovidApiLocation]? {
        await dataRepository.getCovidByCountry(country: country)
    }
}

class CountryDetailViewModel: ObservableObject {
    @Published var dailyStats: [CovidTimelineEntry] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    var countryRequirement: CountryDetailRequirementProtocol
    
    init(countryRequirement: CountryDetailRequirementProtocol = CountryDetailRequirement.shared) {
        self.countryRequirement = countryRequirement
    }
    
    @MainActor
    func loadCountry(country: String) async {
        isLoading = true
        errorMessage = nil
        
        let result = await countryRequirement.getCountryData(country: country)
        isLoading = false
        
        guard let data = result, !data.isEmpty else {
            errorMessage = "No se encontraron datos para este país."
            dailyStats = []
            return
        }
        
        let first = data[0]
        
        var temp: [CovidTimelineEntry] = []
        
        for (date, value) in first.cases {
            if value.total == 0 && value.new == 0 {
                continue
            }
            
            let entry = CovidTimelineEntry(
                date: date,
                total: value.total,
                new: value.new
            )
            temp.append(entry)
        }
        
        temp.sort { $0.date < $1.date }
        
        self.dailyStats = temp
    }
}
