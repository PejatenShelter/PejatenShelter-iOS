//
//  Animal.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 02/05/22.
//

import UIKit

final class Animal {
    var record: AnimalRecord
    
    var name: String {
        didSet {
            record.fields.name = name
        }
    }
    var photo: [Photo]? {
        didSet {
            record.fields.photo = photo
        }
    }
    var breed: String? {
        didSet {
            record.fields.breed = breed
        }
    }
    let adopterIds: [String]?
    var dobString: String {
        didSet {
            record.fields.dobString = dobString
            let ageInMonths = dobString.toDate()?.toAgeInMonths()
            ageString = ageInMonths?.toDateString() ?? ageString
        }
    }
    var ageString: String
    var type: String {
        didSet {
            record.fields.type = type
        }
    }
    var sex: String {
        didSet {
            record.fields.sex = sex
        }
    }
    var healthStatus: String {
        didSet {
            record.fields.healthStatus = healthStatus
        }
    }
    var specialCondition: String {
        didSet {
            record.fields.specialCondition = specialCondition
        }
    }
    var status: String {
        didSet {
            record.fields.status = status
        }
    }
    var selectedImage: UIImage?
    
    init(
        record: AnimalRecord,
        name: String,
        photo: [Photo]?,
        breed: String?,
        adopterIds: [String]?,
        dobString: String,
        ageString: String,
        type: String,
        sex: String,
        healthStatus: String,
        specialCondition: String,
        status: String
    ) {
        self.record = record
        self.name = name
        self.photo = photo
        self.breed = breed
        self.adopterIds = adopterIds
        self.dobString = dobString
        self.ageString = ageString
        self.type = type
        self.sex = sex
        self.healthStatus = healthStatus
        self.specialCondition = specialCondition
        self.status = status
    }
    
    init(animal: Animal) {
        record = animal.record
        name = animal.name
        photo = animal.photo
        breed = animal.breed
        adopterIds = animal.adopterIds
        dobString = animal.dobString
        ageString = animal.ageString
        type = animal.type
        sex = animal.sex
        healthStatus = animal.healthStatus
        specialCondition = animal.specialCondition
        status = animal.status
        selectedImage = animal.selectedImage
    }
    
    func copyValues(from animal: Animal?) {
        guard let animal = animal else { return }
        record = animal.record
        name = animal.name
        photo = animal.photo
        breed = animal.breed
        dobString = animal.dobString
        ageString = animal.ageString
        type = animal.type
        sex = animal.sex
        healthStatus = animal.healthStatus
        specialCondition = animal.specialCondition
        status = animal.status
        selectedImage = animal.selectedImage
    }
}

extension Animal {
    enum AdoptionStatus: String, CaseIterable {
        case notAvailable = "Tidak Tersedia untuk Diadopsi"
        case available = "Tersedia untuk Diadopsi"
        case adopted = "Sudah Diadopsi"
    }
    
    enum Species: String, CaseIterable {
        case dog = "Anjing"
        case cat = "Kucing"
        case other = "Lainnya"
    }
    
    enum Sex: String, CaseIterable {
        case male = "Laki-laki"
        case female = "Perempuan"
    }
    
    enum HealthStatus: String, CaseIterable {
        case unvaccinated = "Belum Divaksin"
        case vaccinated = "Divaksin"
        case sterilized = "Disteril"
        case vaccinatedAndSterilized = "Divaksin dan Disteril"
    }
}
