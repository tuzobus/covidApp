//
//  CovidCountryRequirement.swift
//  covidApp
//
//  Created by Iván FV on 27/11/25.
//

import Foundation

protocol CovidCountryRequirementProtocol {
    func getCountrySummaries(country: String) async -> [CovidCountrySummary]
}

class CovidCountryRequirement: CovidCountryRequirementProtocol {
    static let shared = CovidCountryRequirement()
    
    let dataRepository: CovidRepository
    
    init(dataRepository: CovidRepository = CovidRepository.shared) {
        self.dataRepository = dataRepository
    }
    
    func getCountrySummaries(country: String) async -> [CovidCountrySummary] {
        guard let apiLocations = await dataRepository.getCovidByCountry(country: country),
              !apiLocations.isEmpty else {
            return []
        }
        
        let summaries: [CovidCountrySummary] = apiLocations.compactMap { location in
            let timeline = buildTimeline(from: location)
            
            guard !timeline.isEmpty else { return nil }
            
            let displayName: String
            if let region = location.region, !region.isEmpty {
                displayName = "\(location.country) - \(region)"
            } else {
                displayName = location.country
            }
            
            return CovidCountrySummary(
                displayName: displayName,
                country: location.country,
                region: location.region,
                timeline: timeline
            )
        }
        
        return summaries.sorted { $0.displayName < $1.displayName }
    }
    
    private func buildTimeline(from location: CovidApiLocation) -> [CovidTimelineEntry] {
        let casesDict = location.cases ?? [:]
        let deathsDict = location.deaths ?? [:]
        
        let sortedDates = casesDict.keys.sorted()
        
        var timeline: [CovidTimelineEntry] = []
        
        for date in sortedDates {
            guard let caseStats = casesDict[date] else { continue }
            
            let deathsStats = deathsDict[date]
            
            let entry = CovidTimelineEntry(
                dateString: date,
                totalCases: caseStats.total,
                newCases: caseStats.new,
                totalDeaths: deathsStats?.total,
                newDeaths: deathsStats?.new
            )
            
            timeline.append(entry)
        }
        
        return timeline
    }
}
