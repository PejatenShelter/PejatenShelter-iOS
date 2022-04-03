//
//  AirtableAdapter.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 02/05/22.
//

import Foundation
import SwiftUI

struct AirtableAdapter: ApiService {
    private let apiKey: String = {
        let apiKey = Bundle.main
            .object(forInfoDictionaryKey: "AIRTABLE_API_KEY") as? String
        guard let key = apiKey, !key.isEmpty else { return "" }
        return key
    }()
    
    private let baseKey: String = {
        let baseKey = Bundle.main
            .object(forInfoDictionaryKey: "AIRTABLE_BASE_KEY") as? String
        guard let key = baseKey, !key.isEmpty else { return "" }
        return key
    }()
    
    func makeUrl(for database: DatabaseType, with filter: DatabaseFilter?) -> URL {
        var url = URL(string: "https://api.airtable.com/v0/\(baseKey)/\(tableId(for: database))")!
        if let filter = filter {
            url = url.appending("view", value: viewId(for: filter))
        }
        return url
    }
    
    func makeRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    private func tableId(for database: DatabaseType) -> String {
        switch database {
        case .adopters: return "tblYXBkEJb9awkBod"
        case .animals: return "tblPDiNHijNKDvhJ3"
        }
    }
    
    private func viewId(for filter: DatabaseFilter) -> String {
        switch filter {
        case .animalComplete: return "viwlKz2sqTc5YOxGo"
        case .animalAvailableToAdopt: return "viwj88EYnXj5NtWCM"
        case .adopterComplete: return "viws8R65i7F2R7gWO"
        case .adopterOngoing: return "viw3q2fK7NwJUic8e"
        case .adopterFinished: return "viwyGd0TGxPCnjHjN"
        }
    }
}
