//
//  AnimalListViewModel.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 23/04/22.
//

import Foundation

final class AnimalListViewModel {
    private let animalService: AnimalService
    var animals = [Animal]()
    
    private let pageSize: Int = 6
    var offset: String?
    
    init(animalService: AnimalService) {
        self.animalService = animalService
    }
    
    func getAnimalsCount() -> Int {
        return animals.count
    }
    
    func getAnimal(for index: Int) -> Animal? {
        guard index >= 0,
              index < animals.count else { return nil}
        return animals[index]
    }
    
    func fetchAnimals(
        segment: AnimalListViewController.Segment,
        completion: @escaping (Result<Void,Error>) -> Void
    ) {
        offset = nil
        animalService.fetchAnimals(
            filter: segment.filter(),
            pageSize: pageSize,
            offset: offset
        ) { [weak self] result in
            switch result {
            case .success(let response):
                self?.animals = response.records.map {
                    $0.fields.toAnimal(record: $0)
                }
                self?.offset = response.offset
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMoreAnimals(
        segment: AnimalListViewController.Segment,
        completion: @escaping (Result<Void,Error>) -> Void
    ) {
        guard let offset = offset else {
            completion(.failure(AirtableServiceError.noMoreData))
            return
        }
        animalService.fetchAnimals(
            filter: segment.filter(),
            pageSize: pageSize,
            offset: offset
        ) { [weak self] result in
            switch result {
            case .success(let response):
                let animals = response.records.map {
                    $0.fields.toAnimal(record: $0)
                }
                self?.animals.append(contentsOf: animals)
                self?.offset = response.offset
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func append(animal: Animal) {
        var newAnimals = [animal]
        newAnimals.append(contentsOf: animals)
        animals = newAnimals
    }
}
