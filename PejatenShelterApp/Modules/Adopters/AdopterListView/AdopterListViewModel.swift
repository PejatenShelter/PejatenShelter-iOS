//
//  AdopterListViewModel.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 23/04/22.
//

import Foundation

final class AdopterListViewModel {
    private let adopterService: AdopterService
    private var adopters = [Adopter]()
    
    private let pageSize: Int = 12
    var offset: String?
    
    init(adopterService: AdopterService) {
        self.adopterService = adopterService
    }
    
    func getAdoptersCount() -> Int {
        return adopters.count
    }
    
    func getAdopter(for index: Int) -> Adopter? {
        guard index >= 0,
              index < adopters.count else { return nil }
        return adopters[index]
    }
    
    func fetchAdopters(
        segment: AdopterListViewController.Segment,
        completion: @escaping (Result<Void,Error>) -> Void
    ) {
        offset = nil
        adopterService.fetchAdopters(
            filter: segment.filter(),
            pageSize: pageSize,
            offset: offset
        ) { [weak self] result in
            switch result {
            case .success(let response):
                self?.adopters = response.records.map {
                    $0.fields.toAdopter(record: $0)
                }
                self?.offset = response.offset
                completion(.success(()))
            case .failure(let error):
                print("error fetching: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func fetchMoreAdopters(
        segment: AdopterListViewController.Segment,
        completion: @escaping (Result<Void,Error>) -> Void
    ) {
        guard let offset = offset else {
            completion(.failure(AirtableServiceError.noMoreData))
            return
        }
        adopterService.fetchAdopters(
            filter: segment.filter(),
            pageSize: pageSize,
            offset: offset
        ) { [weak self] result in
            switch result {
            case .success(let response):
                let adopters = response.records.map {
                    $0.fields.toAdopter(record: $0)
                }
                self?.adopters.append(contentsOf: adopters)
                self?.offset = response.offset
                completion(.success(()))
            case .failure(let error):
                print("error fetching more: \(error)")
                completion(.failure(error))
            }
        }
    }
}
