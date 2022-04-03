//
//  CreateAnimalViewModel.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 29/05/22.
//

import Foundation

final class CreateAnimalViewModel {
    
    private let animalService: AnimalService
    private let imageUploadService: ImageUploadService
    
    var animal = CreateAnimalModel()
    
    let rows: [Row] = [
        .name, .photo, .sex, .type,
        .breed, .healthStatus,
        .specialCondition,
        .dob
    ]
    
    init(
        animalService: AnimalService,
        imageUploadService: ImageUploadService
    ) {
        self.animalService = animalService
        self.imageUploadService = imageUploadService
    }
    
    func getRow(rowIndex: Int) -> Row? {
        guard rowIndex >= 0, rowIndex < rows.count else { return nil }
        
        return rows[rowIndex]
    }
    
    func createAnimal(
        completion: @escaping (Result<Animal,Error>) -> ()
    ) {
        if let image = animal.photo {
            imageUploadService.upload(
                image: image
            ) { [weak self] result in
                switch result {
                case .success(let imageUrl):
                    self?.animal.urlString = imageUrl
                    self?.create(completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            create(completion: completion)
        }
    }
    
    private func create(
        completion: @escaping (Result<Animal,Error>) -> ()
    ) {
        animalService.createAnimal(
            animal: animal
        ) { result in
            switch result {
            case .success(let record):
                let animal = record.fields.toAnimal(record: record)
                completion(.success(animal))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
