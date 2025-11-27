//
//  CountryCodeHelper.swift
//  covidApp
//
//  Created by Iván FV on 27/11/25.
//

import Foundation

struct CountryCodeHelper {
    static func code(for country: String) -> String? {
        // Normalizamos un poco el nombre
        let name = country.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        switch name {
        case "canada":
            return "CA"
        case "mexico", "méxico":
            return "MX"
        case "united states", "united states of america", "usa", "us":
            return "US"
        case "brazil", "brasil":
            return "BR"
        case "spain", "españa":
            return "ES"
        case "france":
            return "FR"
        case "germany":
            return "DE"
        case "italy":
            return "IT"
        case "india":
            return "IN"
        case "japan":
            return "JP"
        case "china":
            return "CN"
        case "argentina":
            return "AR"
        case "chile":
            return "CL"
        case "peru", "perú":
            return "PE"
        case "south africa":
            return "ZA"
        default:
            return nil
        }
    }
}
