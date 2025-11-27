//
//  CovidApiService.swift
//  covidApp
//
//  Created by Iván FV on 27/11/25.
//

import Foundation
import Alamofire

class NetworkAPIService {
    static let shared = NetworkAPIService()
    
    private let baseUrl = "https://api.api-ninjas.com/v1/covid19"
    private let apiKey = "KxiR7qTolLMO+mYMatZXPQ==hGByBoS6CBRuaEve"
    
    func getCountryData(country: String) async -> [CovidApiLocation]? {
        let parameters: Parameters = [
            "country": country,
            "type": "cases"
        ]
        
        let headers: HTTPHeaders = [
            "X-Api-Key": apiKey
        ]
        
        guard let url = URL(string: baseUrl) else {
            return nil
        }
        
        let request = AF.request(
            url,
            method: .get,
            parameters: parameters,
            headers: headers
        )
        .validate()
        
        let response = await request.serializingData().response
        
        switch response.result {
        case .success(let data):
            do {
                let decoded = try JSONDecoder().decode([CovidApiLocation].self, from: data)
                return decoded
            } catch {
                print("Decode error: \(error)")
                return nil
            }
        case .failure(let error):
            print("Request error: \(error)")
            return nil
        }
    }
}
