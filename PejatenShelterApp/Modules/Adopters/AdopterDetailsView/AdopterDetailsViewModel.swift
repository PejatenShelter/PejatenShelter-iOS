//
//  AdopterDetailsViewModel.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 16/05/22.
//

import UIKit

final class AdopterDetailsViewModel {
    
    private let adopterService: AdopterService
    var adopter: Adopter?
    var updatedAdopter: Adopter?
    
    var sections: [Section] = [
        .status,
        .personal,
        .house,
        .pets,
        .petCare,
        .experience,
        .preferences
    ]
    
    var isOpen: [Section: Bool] = [
        .status : true,
        .personal : false,
        .house : false,
        .pets : false,
        .petCare : false,
        .experience : false,
        .preferences : false
    ]
    
    init(adopterService: AdopterService) {
        self.adopterService = adopterService
    }
    
    func set(adopter: Adopter) {
        self.adopter = adopter
        self.updatedAdopter = .init(adopter: adopter)
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
        adopter: AdopterRecord,
        completion: @escaping (Result<Void,Error>) -> ()
    ) {
        adopterService.updateAdopter(
            newValue: adopter
        ) { [weak self]  result in
            switch result {
            case .success(let response):
                guard let record = response.records.first else { return }
                self?.adopter = record.fields.toAdopter(record: record)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
