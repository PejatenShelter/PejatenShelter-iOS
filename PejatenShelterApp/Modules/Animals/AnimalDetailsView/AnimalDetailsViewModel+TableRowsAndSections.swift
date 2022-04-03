//
//  AnimalDetailsViewModel+TableRowsAndSections.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 16/05/22.
//

import Foundation

extension AnimalDetailsViewModel {
    
    enum Row: String {
        case name = "Nama"
        case photo = "Foto"
        case sex = "Jenis Kelamin"
        case type = "Jenis Anabul"
        case breed = "Jenis Breed"
        case age = "Umur"
        case dob = "Tanggal Lahir"
        case healthStatus = "Status Kesehatan"
        case specialCondition = "Kondisi Khusus"
        case status = "Status Adopsi"
    }
    
    enum Section: String, CaseIterable {
        case generalInfo = "Tentang Anabul"
        case adoptionInfo = "Status Adopsi Anabul"
        
        func rows() -> [Row] {
            switch self {
            case .generalInfo: return generalInfoRows()
            case .adoptionInfo: return adoptionInfoRows()
            }
        }
        
        private func generalInfoRows() -> [Row] {
            return [ .name, .photo, .sex, .type, .breed, .healthStatus, .specialCondition, .dob, .age ]
        }
        
        private func adoptionInfoRows() -> [Row] {
            return [ .status ]
        }
    }
    
}
