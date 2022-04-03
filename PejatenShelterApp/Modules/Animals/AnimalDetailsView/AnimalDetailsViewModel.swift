//
//  AnimalDetailsViewModel.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 16/05/22.
//

import UIKit

final class AnimalDetailsViewModel {
    
    private let animalService: AnimalService
    private let imageUploadService: ImageUploadService
    var animal: Animal?
    var updatedAnimal: Animal?
    
    var sections: [Section] = [
        .adoptionInfo,
        .generalInfo
    ]
    
    var isOpen: [Section: Bool] = [
        .adoptionInfo : true,
        .generalInfo : true
    ]
    
    init(animalService: AnimalService,
         imageUploadService: ImageUploadService) {
        self.animalService = animalService
        self.imageUploadService = imageUploadService
    }
    
    func set(animal: Animal) {
        self.animal = animal
        self.updatedAnimal = .init(animal: animal)
    }
    
    func getSectionRowCount(for index: Int) -> Int {
        guard let section = getSection(for: index) else { return 0 }
        
        return isOpen[section] ?? false ? section.rows().count : 0
    }
    
    func isOpen(for index: Int) -> Bool {
        guard let section = getSection(for: index) else { return false }
        
        return isOpen[section] ?? false
    }
    
    func getSectionTitle(for index: Int) -> String {
        guard let section = getSection(for: index) else { return "" }
        
        return section.rawValue
    }
    
    func getRow(sectionIndex: Int, rowIndex: Int) -> Row? {
        guard let section = getSection(for: sectionIndex) else { return nil }
        
        let rows = section.rows()
        guard rowIndex >= 0, rowIndex < rows.count else { return nil }
        
        return rows[rowIndex]
    }
    
    private func getSection(for index: Int) -> Section? {
        guard index >= 0, index < sections.count else { return nil }
        return sections[index]
    }
    
    func toggleIsOpen(for index: Int) {
        guard let section = getSection(for: index) else { return }
        
        isOpen[section]?.toggle()
    }
    
    func update(
        animal: Animal,
        completion: @escaping (Result<Void,Error>) -> ()
    ) {
        if let image = animal.selectedImage {
            imageUploadService.upload(
                image: image
            ) { [weak self] result in
                switch result {
                case .success(let imageUrl):
                    animal.photo = [
                        .init(id: nil, urlString: imageUrl, filename: nil, type: nil, size: nil, width: nil, height: nil, thumbnails: nil)
                    ]
                default: break
                }
                self?.update(animal: animal.record, completion: completion)
            }
        } else {
            update(animal: animal.record, completion: completion)
        }
    }
    
    private func update(
        animal: AnimalRecord,
        completion: @escaping (Result<Void,Error>) -> ()
    ) {
        animalService.updateAnimal(
            newValue: animal.removeGeneratedFields()
        ) { [weak self] result in
            switch result {
            case .success(let response):
                guard let record = response.records.first else {
                    completion(.failure(AirtableServiceError.recordNotFound))
                    return
                }
                self?.animal = record.fields.toAnimal(record: record)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
