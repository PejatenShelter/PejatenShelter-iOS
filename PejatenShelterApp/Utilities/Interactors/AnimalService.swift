//
//  AnimalService.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 29/05/22.
//

import Foundation

enum AirtableServiceError: Error {
    case noMoreData
    case recordNotFound
    case unknown
}

protocol AnimalService {
    func fetchAnimals(
        filter: DatabaseFilter,
        pageSize: Int,
        offset: String?,
        completion: @escaping (Result<AnimalResponse, Error>) -> Void
    )
    
    func updateAnimal(
        newValue: AnimalRecord,
        completion: @escaping (Result<AnimalResponse, Error>) -> Void
    )
    
    func createAnimal(
        animal: CreateAnimalModel,
        completion: @escaping (Result<AnimalRecord, Error>) -> Void
    )
}

struct AnimalServiceImpl: AnimalService {
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func fetchAnimals(
        filter: DatabaseFilter,
        pageSize: Int,
        offset: String?,
        completion: @escaping (Result<AnimalResponse, Error>) -> Void
    ) {
        var url = apiService.makeUrl(for: .animals, with: filter)
            .appending("pageSize", value: pageSize.description)
        
        if offset != nil {
            url = url.appending("offset", value: offset)
        }
        
        fetchAnimals(with: url, completion: completion)
    }
    
    func updateAnimal(
        newValue: AnimalRecord,
        completion: @escaping (Result<AnimalResponse, Error>) -> Void
    ) {
        var request = apiService.makeRequest(
            with: apiService.makeUrl(for: .animals, with: nil)
        )
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PATCH"
        
        let body = AnimalResponse(
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
                    let response = try decoder.decode(AnimalResponse.self, from: data)
                    completion(.success(response))
                } catch let err {
                    completion(.failure(err))
                }
            }
        }.resume()
    }
    
    private func fetchAnimals(
        with url: URL,
        completion: @escaping (Result<AnimalResponse, Error>) -> Void
    ) {
        var request = apiService.makeRequest(with: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(AnimalResponse.self, from: data)
                    completion(.success(response))
                } catch let err {
                    completion(.failure(err))
                }
            }
        }.resume()
    }
    
    func createAnimal(
        animal: CreateAnimalModel,
        completion: @escaping (Result<AnimalRecord, Error>) -> Void
    ) {
        var request = apiService.makeRequest(
            with: apiService.makeUrl(
                for: .animals, with: nil
            )
        )
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let body = AnimalRecord.create(from: animal)
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let record = try decoder.decode(AnimalRecord.self, from: data)
                    completion(.success(record))
                } catch let err {
                    completion(.failure(err))
                }
            }
        }.resume()
    }
    
}
