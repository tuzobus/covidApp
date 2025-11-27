//
//  CovidDashboardViewModel.swift
//  covidApp
//
//  Created by Iván FV on 27/11/25.
//

import Foundation
import Combine

class CovidDashboardViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var summaries: [CovidCountrySummary] = []
    @Published var currentCountryLabel: String = ""
    
    let countryRequirement: CovidCountryRequirementProtocol
    let preferenceRequirement: CountryPreferenceRequirementProtocol
    
    init(
        countryRequirement: CovidCountryRequirementProtocol = CovidCountryRequirement.shared,
        preferenceRequirement: CountryPreferenceRequirementProtocol = CountryPreferenceRequirement.shared
    ) {
        self.countryRequirement = countryRequirement
        self.preferenceRequirement = preferenceRequirement
    }
    
    @MainActor
    func loadInitialCountry() async {
        let last = preferenceRequirement.getLastCountry() ?? "Canada"
        searchText = last
        await loadCountry()
    }
    
    @MainActor
    func loadCountry() async {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmed.isEmpty else {
            errorMessage = "Escribe el nombre de un país."
            summaries = []
            return
        }
        
        isLoading = true
        errorMessage = nil
        summaries = []
        
        let countryName = trimmed
        
        let result = await countryRequirement.getCountrySummaries(country: countryName)
        
        if result.isEmpty {
            self.errorMessage = "No se encontraron datos para \"\(countryName)\"."
            self.currentCountryLabel = ""
        } else {
            self.summaries = result
            self.currentCountryLabel = countryName
            self.preferenceRequirement.setLastCountry(country: countryName)
        }
        
        isLoading = false
    }
    
    func latestEntry(for summary: CovidCountrySummary) -> CovidTimelineEntry? {
        summary.timeline.last
    }
}
