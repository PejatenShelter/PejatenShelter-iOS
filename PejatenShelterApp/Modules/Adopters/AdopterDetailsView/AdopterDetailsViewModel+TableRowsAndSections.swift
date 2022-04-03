//
//  AdopterDetailsViewModel+TableRowsAndSections.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 16/05/22.
//

import Foundation

extension AdopterDetailsViewModel {
    enum Row: String {
        case hasKnownPets = "Hewan di Pejaten Shelter"
        case animalsToAdopt = "Hewan Yang Ingin Diadopsi"
        case reasonChoosingAnimals = "Alasan Memilih Hewan"
        case animalTypePreference = "Jenis Hewan"
        case detailedAnimalTypePreference = "Keterangan Tambahan Jenis Hewan"
        case animalTypePreferenceReason = "Alasan Preferensi Jenis Hewan"
        case animalStylePreference = "Preferensi Ciri"
        case animalStylePreferenceReason = "Alasan Preferensi Ciri"
        case animalCharacterPreference = "Preferensi Sifat"
        case animalCharacterPreferenceReason = "Alasan Preferensi Sifat"
        case animalGenderPreference = "Preferensi Kelamin"
        case animalGenderPreferenceReason = "Alasan Preferensi Kelamin"
        case name = "Nama"
        case identityNumber = "NIK"
        case gender = "Gender"
        case personalPhoneNumber = "No. HP"
        case experienceLevel = "Pengalaman Memelihara Hewan"
        case ownedPetsAmount = "Peliharaan Total"
        case currentPetsAmount = "Peliharaan Sekarang"
        case currentPetsInfo = "Info Peliharaan"
        case petsVaccinationStatus = "Status Vaksinasi"
        case lengthOfStay = "Lama Tinggal"
        case homeOwnershipStatus = "Kepemilikan"
        case isAllowedToOwnPets = "Izin Hewan Peliharaan"
        case hasFences = "Pagar Tersedia"
        case hasOutdoorYard = "Halaman Rumah"
        case experienceOwningPets = "Pengalaman Memelihara"
        case registeredAddress = "Alamat KTP"
        case currentAddress = "Alamat"
        case homePhoneNumber = "No. Telp"
        case buildingType = "Jenis Bangunan"
        case houseOccupantsAmount = "Penghuni"
        case animalStayInfo = "Tempat Hewan"
        case houseAreaSize = "Luas"
        case petCareLocationInfo = "Penitipan Hewan"
        case knownPetCare = "Kontak Klinik / Dokter"
        case clinicName = "Nama Klinik"
        case clinicAddress = "Alamat Klinik"
        case veterinaryName = "Nama Dokter"
        case veterinaryPhoneNumber = "No. Telepon Dokter"
        case hasBackupKeeper = "Pengurus Cadangan"
        case backupKeeperContactInformation = "Kontak Pengurus"
        case email = "Email"
        case socialMedia = "Media Sosial"
        case status = "Status"
        case submissionDate = "Tanggal Pengumpulan"
    }
    
    enum Section: String, CaseIterable {
        case status = "Status Pengadopsian"
        case personal = "Informasi Personal Adopter"
        case house = "Informasi Rumah Adopter"
        case pets = "Hewan Peliharaan Adopter"
        case petCare = "Perawatan Anabul Adopter"
        case experience = "Pengalaman Adopter"
        case preferences = "Preferensi Adopter"
        
        func rows() -> [Row] {
            switch self {
            case .status: return statusRows()
            case .personal: return personalInfoRows()
            case .house: return houseInfoRows()
            case .pets: return petsInfoRows()
            case .petCare: return petCareInfoRows()
            case .experience: return experienceInfoRows()
            case .preferences: return preferencesInfoRows()
            }
        }
        
        private func statusRows() -> [Row] {
            return [.status]
        }
        
        private func personalInfoRows() -> [Row] {
            return [
                .name,
                .gender,
                .identityNumber,
                .registeredAddress,
                .personalPhoneNumber,
                .email,
                .socialMedia
            ]
        }
        
        private func houseInfoRows() -> [Row] {
            return [
                .currentAddress,
                .homePhoneNumber,
                .lengthOfStay,
                .homeOwnershipStatus,
                .houseOccupantsAmount,
                .isAllowedToOwnPets,
                .buildingType,
                .hasFences,
                .hasOutdoorYard,
                .houseAreaSize,
                .animalStayInfo
            ]
        }
        
        private func petsInfoRows() -> [Row] {
            return [
                .currentPetsAmount,
                .ownedPetsAmount,
                .currentPetsInfo,
                .petsVaccinationStatus
            ]
        }
        
        private func petCareInfoRows() -> [Row] {
            return [
                .petCareLocationInfo,
                .knownPetCare,
                .clinicName,
                .clinicAddress,
                .veterinaryName,
                .veterinaryPhoneNumber,
                .hasBackupKeeper,
                .backupKeeperContactInformation
            ]
        }
        
        private func experienceInfoRows() -> [Row] {
            return [
                .experienceLevel,
                .experienceOwningPets
            ]
        }
        
        private func preferencesInfoRows() -> [Row] {
            return [
                .animalsToAdopt,
                .reasonChoosingAnimals,
                .animalTypePreference,
                .detailedAnimalTypePreference,
                .animalTypePreferenceReason,
                .animalStylePreference,
                .animalStylePreferenceReason,
                .animalCharacterPreference,
                .animalCharacterPreferenceReason,
                .animalGenderPreference,
                .animalGenderPreferenceReason
            ]
        }
    }
}
