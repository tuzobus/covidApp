//
//  CovidModels.swift
//  covidApp
//
//  Created by Iván FV on 27/11/25.
//

import Foundation

struct CovidApiLocation: Codable, Identifiable{
    var id: String {
        if let region, !region.isEmpty {
            return "\(country)-\(region)"
        }
        return country
    }
    
    let country: String
    let region: String?
    
    let cases : [String: CovidApiDayStats]?
    
    let deaths: [String: CovidApiDayStats]?
}

struct CovidApiDayStats: Codable {
    let total: Int
    let new: Int
}

struct CovidTimelineEntry: Identifiable {
    let id = UUID()
    
    let dateString: String
    
    let totalCases: Int
    let newCases: Int
    
    let totalDeaths: Int?
    let newDeaths: Int?
}

struct CovidCountrySummary: Identifiable {
    let id = UUID()
    
    let displayName: String
    
    let country: String
    let region: String?
    
    let timeline: [CovidTimelineEntry]
    
    var latest: CovidTimelineEntry? {
        return timeline.last
    }
}
