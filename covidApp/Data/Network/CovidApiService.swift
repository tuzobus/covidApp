//
//  CovidApiService.swift
//  covidApp
//
//  Created by Iván FV on 27/11/25.
//

import Foundation
import Alamofire

struct Api {
    static let base = "https://api.api-ninjas.com/v1"
    
    struct routes {
        static let covid19 = "/covid19"
    }
}

class NetworkAPIService {
    static let shared = NetworkAPIService()
    
    private let apiKey = "KxiR7qTolLMO+mYMatZXPQ==hGByBoS6CBRuaEve"
    
    func getCovidByCountry(country: String) async -> [CovidApiLocation]? {
        guard let url = URL(string: "\(Api.base)\(Api.routes.covid19)") else {
            return nil
        }
        
        let parameters: Parameters = [
            "country": country
        ]
        
        let headers: HTTPHeaders = [
            "X-Api-Key": apiKey
        ]
        
        let taskRequest = AF.request(
            url,
            method: .get,
            parameters: parameters,
            headers: headers
        ).validate()
        
        let response = await taskRequest.serializingData().response
        
        switch response.result {
        case .success(let data):
            do {
                return try JSONDecoder().decode([CovidApiLocation].self, from: data)
            } catch {
                debugPrint("Decoding error:", error.localizedDescription)
                return nil
            }
        case .failure(let error):
            debugPrint("Request error:", error.localizedDescription)
            return nil
        }
    }
    
    func getGlobalSnapshot(date: String) async -> [CovidApiLocation]? {
        guard let url = URL(string: "\(Api.base)\(Api.routes.covid19)") else {
            return nil
        }
        
        let parameters: Parameters = [
            "date": date
        ]
        
        let headers: HTTPHeaders = [
            "X-Api-Key": apiKey
        ]
        
        let taskRequest = AF.request(
            url,
            method: .get,
            parameters: parameters,
            headers: headers
        ).validate()
        
        let response = await taskRequest.serializingData().response
        
        switch response.result {
        case .success(let data):
            do {
                return try JSONDecoder().decode([CovidApiLocation].self, from: data)
            } catch {
                debugPrint("Decoding error (snapshot):", error.localizedDescription)
                return nil
            }
        case .failure(let error):
            debugPrint("Request error (snapshot):", error.localizedDescription)
            return nil
        }
    }
}
