//
//  AdopterResponse.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 02/05/22.
//

import Foundation

typealias PhoneNumber = String

enum YesOrNo: String, Codable {
    case yes = "Ya"
    case no = "Tidak"
    
    func toBool() -> Bool {
        switch self {
        case .yes: return true
        case .no: return false
        }
    }
}

struct AdopterResponse: Codable {
    let records: [AdopterRecord]
    let offset: String?
}

struct AdopterRecord: Codable {
    let id: String
    var fields: AdopterField
}

struct AdopterField: Codable {
    let hasKnownPets: Adopter.HasKnownPets
    let animalToAdopt: String?
    let reasonChoosingAnimals: String?
    let animalTypePreference: [Adopter.AnimalType]?
    let detailedAnimalTypePreference: String?
    let animalTypePreferenceReason: String?
    let animalStylePreference: String?
    let animalStylePreferenceReason: String?
    let animalCharacterPreference: String?
    let animalCharacterPreferenceReason: String?
    let animalGenderPreference: Adopter.AnimalGenderPreference?
    let animalGenderPreferenceReason: String?
    let name: String
    let identityNumber: String
    let gender: Adopter.Gender
    let personalPhoneNumber: PhoneNumber
    let experienceLevel: Adopter.ExperienceLevel
    let ownedPetsAmount: Int?
    let currentPetsAmount: Int?
    let currentPetsInfo: String?
    let petsVaccinationStatus: Adopter.PetsVaccinationStatus?
    let lengthOfStay: Month
    let homeOwnershipStatus: Adopter.HomeOwnershipStatus
    let isAllowedToOwnPets: YesOrNo
    let hasFences: YesOrNo
    let hasOutdoorYard: YesOrNo
    let experienceOwningPets: Month?
    let registeredAddress: String
    let isLivingInRegisteredAddress: YesOrNo
    let currentAddress: String?
    let homePhoneNumber: PhoneNumber
    let buildingType: Adopter.BuildingType
    let houseOccupantsAmount: Int
    let animalStayInfo: String
    let houseAreaSize: Double
    let petCareLocationInfo: String
    let knownPetCare: [Adopter.PetCare]?
    let clinicName: String?
    let clinicAddress: String?
    let veterinaryName: String?
    let veterinaryPhoneNumber: PhoneNumber?
    let hasBackupKeeper: YesOrNo
    let backupKeeperContactInformation: String?
    let email: String?
    let socialMedia: String?
    var status: String
    
    enum ID: String {
        case hasKnownPets = "fldCnhhRrn98PNWcw"
        case animalToAdopt = "fldlTo6Yz9Li2VLF1"
        case reasonChoosingAnimals = "fldhCvIaD7W460LWk"
        case animalTypePreference = "fldw6V2FOMLlJNDC7"
        case detailedAnimalTypePreference = "fldNZSaeE7qzLOroN"
        case animalTypePreferenceReason = "fldxK4rpPBd3NXFKb"
        case animalStylePreference = "flddo8zq8tP4ri4i2"
        case animalStylePreferenceReason = "fld74DhZy97l8NPgy"
        case animalCharacterPreference = "fldpGGsgXPQlwo8iq"
        case animalCharacterPreferenceReason = "fldLi7QCSvWF5RUY5"
        case animalGenderPreference = "fldNHeIphO562Y04y"
        case animalGenderPreferenceReason = "fldmcghQsl5sAmvMI"
        case name = "fldlQlTCgFi2baeZr"
        case identityNumber = "flddhG9csI3Ma4KIF"
        case gender = "fldym5vjFE6GCrvpU"
        case personalPhoneNumber = "fldNUm1s7SWWuVjii"
        case experienceLevel = "flde9Gvv5w1EAkuLH"
        case ownedPetsAmount = "flduSlxIjXx0WFVeo"
        case currentPetsAmount = "fld5Jrre8H4liNxYR"
        case currentPetsInfo = "fld1VVLeB6E41TUgs"
        case petsVaccinationStatus = "fldq8Aw1H2dk0eyy1"
        case lengthOfStay = "fldeMRbC90LOgrpba"
        case homeOwnershipStatus = "fldIKx6XN4FS10Qci"
        case isAllowedToOwnPets = "fldVlUOzffBuLQ0gr"
        case hasFences = "fldhuUgtl95opd17h"
        case hasOutdoorYard = "fldoWoUirTtMzeaVj"
        case experienceOwningPets = "fldoDN2SbgWDIyS2V"
        case registeredAddress = "fldKDxhmO5ShFkuI4"
        case isLivingInRegisteredAddress = "fld9i9BJ2j7JVhLTd"
        case currentAddress = "fldqBY4ON2hdb8cBc"
        case homePhoneNumber = "fldbg41bx7dKRLFun"
        case buildingType = "fldilSiC5WlBAAd1b"
        case houseOccupantsAmount = "flddqqLzPalgNjs2F"
        case animalStayInfo = "fldsuPKgMaAb4VqQu"
        case houseAreaSize = "fldLysLHFy5nplRki"
        case petCareLocationInfo = "fldgEM2rPilh2XTws"
        case knownPetCare = "fld5WDULLWopTanvg"
        case clinicName = "fldfEWe2JMcdT9SJS"
        case clinicAddress = "fldee1jCox5JvIvQt"
        case veterinaryName = "fldQneFDrzXJTAe7H"
        case veterinaryPhoneNumber = "fldIVJTg7bccdbJWo"
        case hasBackupKeeper = "fldgbV2Z2ZfqHuZ8T"
        case backupKeeperContactInformation = "fldRoaajC6yrF7kVr"
        case email = "fldlCqChsrwujyzTW"
        case socialMedia = "fldHcudrmRpNgqOCS"
        case status = "fldHez5wYS63oqjYT"
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case hasKnownPets = "Hewan di Pejaten Shelter"
        case animalToAdopt = "Nama Hewan Yang Ingin Diadopsi"
        case reasonChoosingAnimals = "Alasan Memilih Hewan"
        case animalTypePreference = "Jenis Hewan"
        case detailedAnimalTypePreference = "Keterangan Tambahan Jenis Hewan"
        case animalTypePreferenceReason = "Alasan Preferensi Jenis Hewan"
        case animalStylePreference = "Preferensi Warna / Ciri Hewan"
        case animalStylePreferenceReason = "Alasan Preferensi Warna / Ciri Hewan"
        case animalCharacterPreference = "Preferensi Sifat / Karakter Hewan"
        case animalCharacterPreferenceReason = "Alasan Preferensi Sifat / Karakter Hewan"
        case animalGenderPreference = "Preferensi Jenis Kelamin Hewan"
        case animalGenderPreferenceReason = "Alasan Preferensi Jenis Kelamin Hewan"
        case name = "Nama Lengkap"
        case identityNumber = "NIK"
        case gender = "Gender"
        case personalPhoneNumber = "Nomor Handphone"
        case experienceLevel = "Pengalaman Memelihara Hewan"
        case ownedPetsAmount = "Jumlah Peliharaan Total"
        case currentPetsAmount = "Jumlah Hewan Peliharaan Sekarang"
        case currentPetsInfo = "Hewan Peliharaan Sekarang"
        case petsVaccinationStatus = "Vaksinasi dan Sterilisasi Hewan Peliharaan"
        case lengthOfStay = "Lama Tinggal (Bulan)"
        case homeOwnershipStatus = "Kepemilikan Rumah"
        case isAllowedToOwnPets = "Izin Hewan Peliharaan"
        case hasFences = "Ketersediaan Pagar Rumah"
        case hasOutdoorYard = "Ketersediaan Halaman Rumah"
        case experienceOwningPets = "Waktu Pengalaman Memelihara (Bulan)"
        case registeredAddress = "Alamat KTP"
        case isLivingInRegisteredAddress = "Kesesuaian Alamat KTP"
        case currentAddress = "Alamat Sekarang"
        case homePhoneNumber = "Nomor Telepon Rumah"
        case buildingType = "Jenis Bangunan"
        case houseOccupantsAmount = "Jumlah Penghuni Rumah"
        case animalStayInfo = "Tempat Tinggal Hewan"
        case houseAreaSize = "Luas Rumah"
        case petCareLocationInfo = "Penitipan Hewan"
        case knownPetCare = "Kontak Klinik / Dokter Hewan"
        case clinicName = "Nama Klinik Hewan"
        case clinicAddress = "Alamat Klinik Hewan"
        case veterinaryName = "Nama Dokter Hewan"
        case veterinaryPhoneNumber = "Nomor Telepon Dokter Hewan"
        case hasBackupKeeper = "Pengurus Cadangan"
        case backupKeeperContactInformation = "Informasi Kontak Pengurus Cadangan"
        case email = "Email"
        case socialMedia = "Social Media (Facebook / Instagram / Twitter)"
        case status = "Status"
    }
    
    func toAdopter(record: AdopterRecord) -> Adopter {
        let adopter = Adopter(
            record: record,
            info: .init(
                name: name,
                gender: gender,
                identityNumber: identityNumber,
                registeredAddress: registeredAddress,
                phoneNumber: personalPhoneNumber,
                email: email,
                socialMedia: socialMedia
            ),
            experience: .init(
                level: experienceLevel,
                owningPets: experienceOwningPets ?? 0
            ),
            preferences: .init(
                animal: .init(
                    name: animalToAdopt,
                    reason: reasonChoosingAnimals
                ),
                type: .init(
                    values: animalTypePreference,
                    details: detailedAnimalTypePreference,
                    reason: animalTypePreferenceReason
                ),
                style: .init(
                    value: animalStylePreference,
                    reason: animalStylePreferenceReason
                ),
                character: .init(
                    value: animalCharacterPreference,
                    reason: animalCharacterPreferenceReason
                ),
                gender: .init(
                    value: animalGenderPreference ?? .none,
                    reason: animalGenderPreferenceReason
                )
            ),
            house: .init(
                address: currentAddress ?? registeredAddress,
                phoneNumber: homePhoneNumber,
                lengthOfStay: lengthOfStay,
                ownershipStatus: homeOwnershipStatus,
                isAllowedToOwnPets: isAllowedToOwnPets.toBool(),
                buildingType: buildingType,
                hasFences: hasFences.toBool(),
                hasOutdoorYard: hasOutdoorYard.toBool(),
                occupantsAmount: houseOccupantsAmount,
                areaSize: houseAreaSize,
                animalStayInfo: animalStayInfo
            ),
            pets: .init(
                amount: .init(
                    current: currentPetsAmount ?? 0,
                    owned: ownedPetsAmount ?? 0
                ),
                info: currentPetsInfo,
                vaccinationStatus: petsVaccinationStatus
            ),
            petCare: .init(
                location: petCareLocationInfo,
                known: knownPetCare,
                clinic: .init(
                    name: clinicName,
                    address: clinicAddress
                ),
                veterinary: .init(
                    name: veterinaryName,
                    phoneNumber: veterinaryPhoneNumber
                ),
                hasBackupKeeper: hasBackupKeeper.toBool(),
                backupKeeperInfo: backupKeeperContactInformation
            ),
            form: .init(
                status: status
            )
        )
        return adopter
    }
}
