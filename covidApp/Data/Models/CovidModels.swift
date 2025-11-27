//
//  CovidModels.swift
//  covidApp
//
//  Created by Iván FV on 27/11/25.
//

import Foundation

struct CovidApiLocation: Codable {
    var country: String
    var region: String?
    var cases: [String: CovidApiDayStats]
}

struct CovidApiDayStats: Codable {
    var total: Int
    var new: Int
}

struct CovidTimelineEntry: Identifiable {
    var id = UUID()
    var date: String
    var total: Int
    var new: Int
}

struct CovidCountrySummary: Identifiable {
    var id = UUID()
    
    var displayName: String
    
    var country: String
    var region: String?
    
    var timeline: [CovidTimelineEntry]
}
