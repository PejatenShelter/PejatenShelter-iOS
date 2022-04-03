//
//  ApiService.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 29/05/22.
//

import Foundation

enum DatabaseType {
    case adopters
    case animals
}

enum DatabaseFilter {
    case animalComplete
    case animalAvailableToAdopt
    case adopterComplete
    case adopterOngoing
    case adopterFinished
}

protocol ApiService {
    func makeUrl(for database: DatabaseType, with filter: DatabaseFilter?) -> URL 
    func makeRequest(with url: URL) -> URLRequest
}
