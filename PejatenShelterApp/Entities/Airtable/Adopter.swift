//
//  Adopter.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 15/05/22.
//

import Foundation

final class Adopter {
    
    var record: AdopterRecord
    
    let info: PersonalInformation
    struct PersonalInformation {
        let name: String
        let gender: Gender
        let identityNumber: String
        let registeredAddress: String // moved from additional info
        let phoneNumber: PhoneNumber
        let email: String?
        let socialMedia: String?
    }
    
    let experience: Experience // taken from additional info
    struct Experience {
        let level: ExperienceLevel
        let owningPets: Month
    }
    
    let preferences: AdoptionPreferences // renamed from adoption form
    struct AdoptionPreferences {
        let animal: AnimalPreferences?
        struct AnimalPreferences {
            let name: String?
            let reason: String?
            
            init?(name: String?, reason: String?) {
                guard let name = name else { return nil }
                self.name = name
                self.reason = reason
            }
        }
        
        let type: TypePreferences? // combined
        struct TypePreferences {
            let values: [AnimalType]
            let details: String?
            let reason: String?
            
            init?(values: [AnimalType]?, details: String?, reason: String?) {
                guard let values = values else { return nil }
                self.values = values
                self.details = details
                self.reason = reason
            }
        }
        
        let style: StylePreference?
        struct StylePreference {
            let value: String
            let reason: String?
            
            init?(value: String?, reason: String?) {
                guard let value = value else { return nil }
                self.value = value
                self.reason = reason
            }
        }
        
        let character: CharacterPreference?
        struct CharacterPreference {
            let value: String
            let reason: String?
            
            init?(value: String?, reason: String?) {
                guard let value = value else { return nil }
                self.value = value
                self.reason = reason
            }
        }
        
        let gender: GenderPreference?
        struct GenderPreference {
            let value: AnimalGenderPreference
            let reason: String?
            
            init?(value: AnimalGenderPreference, reason: String?) {
                guard value != .none else { return nil }
                self.value = value
                self.reason = reason
            }
        }
    }
    
    let house: HouseInformation
    struct HouseInformation {
        let address: String // moved from personal info
        let phoneNumber: PhoneNumber // moved from personal info
        let lengthOfStay: Month // moved from additional info
        let ownershipStatus: HomeOwnershipStatus // moved from additional info
        let isAllowedToOwnPets: Bool // moved from additional
        let buildingType: BuildingType
        let hasFences: Bool
        let hasOutdoorYard: Bool
        let occupantsAmount: Int
        let areaSize: Double
        let animalStayInfo: String // moved from pets information
    }
    
    let pets: PetsInformation
    struct PetsInformation {
        let amount: PetsAmount
        struct PetsAmount {
            let current: Int
            let owned: Int
        }
        
        let info: String?
        let vaccinationStatus: PetsVaccinationStatus?
    }
    
    let petCare: PetCareInformation
    struct PetCareInformation {
        let location: String?
        let known: [PetCare]?
        
        let clinic: ClinicInformation?
        struct ClinicInformation {
            let name: String
            let address: String
            
            init?(name: String?, address: String?) {
                guard let name = name, let address = address else { return nil }
                self.name = name
                self.address = address
            }
        }
        
        let veterinary: VeterinaryInformation?
        struct VeterinaryInformation {
            let name: String
            let phoneNumber: PhoneNumber
            
            init?(name: String?, phoneNumber: PhoneNumber?) {
                guard let name = name, let phoneNumber = phoneNumber else { return nil }
                self.name = name
                self.phoneNumber = phoneNumber
            }
        }
        
        let hasBackupKeeper: Bool
        let backupKeeperInfo: String?
    }
    
    var form: Form {
        didSet {
            self.record.fields.status = form.status
        }
    }
    
    struct Form {
        let status: String
    }
    
    init(
        record: AdopterRecord,
        info: PersonalInformation,
        experience: Experience,
        preferences: AdoptionPreferences,
        house: HouseInformation,
        pets: PetsInformation,
        petCare: PetCareInformation,
        form: Form
    ) {
        self.record = record
        self.info = info
        self.experience = experience
        self.preferences = preferences
        self.house = house
        self.pets = pets
        self.petCare = petCare
        self.form = form
    }
    
    init(adopter: Adopter) {
        record = adopter.record
        info = adopter.info
        experience = adopter.experience
        preferences = adopter.preferences
        house = adopter.house
        pets = adopter.pets
        petCare = adopter.petCare
        form = adopter.form
    }
    
    func changeStatus(to status: String?) {
        guard let status = status, !status.isEmpty else { return }
        
        form = .init(status: status)
    }
}

extension Adopter {
    enum ExperienceLevel: String, Codable {
        case neverOwnedPets = "Tidak Pernah Memelihara"
        case ownedPetsBefore = "Pernah Tapi Sedang Tidak Memelihara"
        case currentlyOwningPets = "Pernah dan Masih Memelihara"
    }
    
    enum PetsVaccinationStatus: String, Codable {
        case none = "Belum Sama Sekali"
        case some = "Sudah Sebagian"
        case all = "Sudah Semua"
        case unknown = "Kurang Tahu"
    }
    
    enum HomeOwnershipStatus: String, Codable {
        case houseOwner = "Pemilik Rumah"
        case houseRenter = "Penyewa Rumah"
        case roomRenter = "Penyewa Ruangan / Kos"
        case familyHouse = "Rumah Orang Tua atau Kerabat"
    }
    
    enum PetCare: String, Codable {
        case clinic = "Klinik Hewan"
        case veterinary = "Dokter Hewan"
    }
    
    enum Gender: String, Codable {
        case male = "Laki-laki"
        case female = "Perempuan"
    }
    
    enum BuildingType: String, Codable {
        case housingComplex = "Komplek"
        case apartment = "Apartment"
        case townHouse = "Town House / Cluster"
        case other = "Lainnya"
    }
    
    enum HasKnownPets: String, Codable {
        case hasNotKnown = "Belum Tahu"
        case hasKnown = "Sudah Tahu"
    }
    
    enum AnimalType: String, Codable {
        case dog = "Anjing"
        case cat = "Kucing"
        case other = "Lainnya"
    }
    
    enum AnimalGenderPreference: String, Codable {
        case male = "Laki-laki"
        case female = "Perempuan"
        case none = "Tidak Ada Preferensi"
    }
    
    enum FormStatus: String, CaseIterable {
        case formSubmission = "Review Form"
        case interview = "Interview"
        case houseSurvey = "Survey Rumah"
        case canceled = "Dibatalkan"
        case rejected = "Ditolak"
        case accepted = "Diterima"
    }
}
