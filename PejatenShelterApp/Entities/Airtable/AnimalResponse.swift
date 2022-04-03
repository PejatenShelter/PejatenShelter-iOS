//
//  AnimalResponse.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 03/05/22.
//

import Foundation

struct AnimalResponse: Codable {
    let records: [AnimalRecord]
    let offset: String?
}

struct AnimalRecord: Codable {
    let id: String?
    var fields: AnimalField
    
    static func create(from animal: CreateAnimalModel) -> AnimalRecord {
        return .init(
            id: nil,
            fields: .init(
                id: nil,
                name: animal.name,
                photo: [
                    .init(id: nil, urlString: animal.urlString, filename: nil, type: nil, size: nil, width: nil, height: nil, thumbnails: nil)
                ],
                breed: animal.breed,
                adopterIds: nil,
                dobString: animal.dobString,
                ageString: nil,
                type: animal.type,
                sex: animal.sex,
                healthStatus: animal.healthStatus,
                specialCondition: animal.specialCondition,
                number: nil,
                status: animal.status
            )
        )
    }
    
    func removeGeneratedFields() -> AnimalRecord {
        return .init(
            id: id,
            fields: .init(
                id: nil,
                name: fields.name,
                photo: fields.photo,
                breed: fields.breed,
                adopterIds: nil,
                dobString: fields.dobString,
                ageString: nil,
                type: fields.type,
                sex: fields.sex,
                healthStatus: fields.healthStatus,
                specialCondition: fields.specialCondition,
                number: nil,
                status: fields.status
            )
        )
    }
}

struct AnimalField: Codable {
    let id: String?
    var name: String
    var photo: [Photo]?
    var breed: String?
    let adopterIds: [String]?
    var dobString: String
    let ageString: String?
    var type: String
    var sex: String
    var healthStatus: String
    var specialCondition: String
    let number: Int?
    var status: String
    
    enum ID: String {
        case id = "fldpRMufrlzeQkO7W"
        case name = "fldCDqV1NgRYRohc2"
        case photo = "fldNBeZJKxcM8649W"
        case breed = "fld6g4XUk8FQLp7ck"
        case adopterIds = "fld6fZFXEqqLIhicS"
        case dobString = "fldEr5yIqQNHp9myx"
        case ageString = "fldJnQR7sxqEmjeIw"
        case type = "fldc1eMJsYBbJjERk"
        case sex = "fld5UYcy5r9Dumv09"
        case healthStatus = "fldxcTs8mdvsKIvVw"
        case specialCondition = "fld1MbuV6zkaDKJxW"
        case number = "fldmG2ArrP5LmqJJh"
        case status = "fldHez5wYS63oqjYT"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Nama"
        case photo = "Foto"
        case breed = "Jenis Breed"
        case adopterIds = "Adopters"
        case dobString = "Tanggal Lahir"
        case ageString = "Umur"
        case type = "Jenis Hewan"
        case sex = "Jenis Kelamin"
        case healthStatus = "Status Kesehatan"
        case specialCondition = "Kondisi Khusus"
        case number = "Number"
        case status = "Status"
    }
    
    func toAnimal(record: AnimalRecord) -> Animal {
        return .init(
            record: record,
            name: name,
            photo: photo,
            breed: breed,
            adopterIds: adopterIds,
            dobString: dobString,
            ageString: ageString ?? "",
            type: type,
            sex: sex,
            healthStatus: healthStatus,
            specialCondition: specialCondition,
            status: status
        )
    }
}
