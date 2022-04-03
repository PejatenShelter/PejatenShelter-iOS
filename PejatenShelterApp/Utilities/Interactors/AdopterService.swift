//
//  AdopterService.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 29/05/22.
//

import Foundation

protocol AdopterService {
    func fetchAdopters(
        filter: DatabaseFilter,
        pageSize: Int,
        offset: String?,
        completion: @escaping (Result<AdopterResponse, Error>) -> Void
    )
    
    func updateAdopter(
        newValue: AdopterRecord,
        completion: @escaping (Result<AdopterResponse, Error>) -> Void
    )
}

struct AdopterServiceImpl: AdopterService {
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func fetchAdopters(
        filter: DatabaseFilter,
        pageSize: Int,
        offset: String?,
        completion: @escaping (Result<AdopterResponse, Error>) -> Void
    ) {
        var url = apiService.makeUrl(for: .adopters, with: filter)
            .appending("pageSize", value: pageSize.description)
        
        if offset != nil {
            url = url.appending("offset", value: offset)
        }
        
        fetchAdopters(with: url, completion: completion)
    }
    
    func updateAdopter(
        newValue: AdopterRecord,
        completion: @escaping (Result<AdopterResponse, Error>) -> Void
    ) {
        var request = apiService.makeRequest(
            with: apiService.makeUrl(for: .adopters, with: nil)
        )
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PATCH"
        
        let body = AdopterResponse(
            records: [newValue],
            offset: nil
        )
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(AdopterResponse.self, from: data)
                    completion(.success(response))
                } catch let err {
                    completion(.failure(err))
                }
            }
        }.resume()
    }
    
    private func fetchAdopters(
        with url: URL,
        completion: @escaping (Result<AdopterResponse, Error>) -> Void
    ) {
        var request = apiService.makeRequest(with: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(AdopterResponse.self, from: data)
                    completion(.success(response))
                } catch let err {
                    completion(.failure(err))
                }
            }
        }.resume()
    }
}
