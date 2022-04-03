//
//  AdopterDetailsTableViewCellFactory.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 28/05/22.
//

import UIKit

struct AdopterDetailsTableViewCell {
    private init() {}
    
    static func make(
        for row: AdopterDetailsViewModel.Row,
        in tableView: UITableView,
        at indexPath: IndexPath,
        with adopter: Adopter
    ) -> UITableViewCell {
        let cell = cell(for: row, in: tableView, at: indexPath)
        cell.backgroundColor = .systemBackground
        setup(cell: cell, for: row, with: adopter)
        return cell
    }
    
    private static func cell(
        for row: AdopterDetailsViewModel.Row,
        in tableView: UITableView,
        at indexPath: IndexPath
    ) -> UITableViewCell {
        switch row {
        case .name,
                .gender,
                .identityNumber,
                .registeredAddress,
                .personalPhoneNumber,
                .email,
                .socialMedia,
                .currentAddress,
                .homePhoneNumber,
                .lengthOfStay,
                .homeOwnershipStatus,
                .houseOccupantsAmount,
                .isAllowedToOwnPets,
                .buildingType, .hasFences,
                .hasOutdoorYard, .houseAreaSize,
                .animalStayInfo,
                .currentPetsAmount,
                .ownedPetsAmount,
                .currentPetsInfo,
                .petsVaccinationStatus,
                .petCareLocationInfo,
                .knownPetCare,
                .clinicName,
                .clinicAddress,
                .veterinaryName,
                .veterinaryPhoneNumber,
                .hasBackupKeeper,
                .backupKeeperContactInformation,
                .experienceLevel,
                .experienceOwningPets,
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
                .animalGenderPreferenceReason,
                .status:
            return tableView.dequeueReusableCell(
                withIdentifier: SubtitleTableViewCell.identifier,
                for: indexPath
            )
        default: return .init()
        }
    }
    
    private static func setup(
        cell: UITableViewCell,
        for row: AdopterDetailsViewModel.Row,
        with adopter: Adopter
    ) {
        switch row {
        case .name:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.info.name
            )
        case .gender:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.info.gender.rawValue
            )
        case .identityNumber:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.info.identityNumber
            )
        case .registeredAddress:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.info.registeredAddress
            )
        case .personalPhoneNumber:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.info.phoneNumber
            )
        case .email:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.info.email ?? "-"
            )
        case .socialMedia:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.info.socialMedia ?? "-"
            )
        case .currentAddress:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.house.address
            )
        case .homePhoneNumber:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.house.phoneNumber
            )
        case .lengthOfStay:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.house.lengthOfStay.toDateString()
            )
        case .homeOwnershipStatus:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.house.ownershipStatus.rawValue
            )
        case .houseOccupantsAmount:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: "\(adopter.house.occupantsAmount.description) Orang"
            )
        case .isAllowedToOwnPets:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.house.isAllowedToOwnPets.toLocalizedString()
            )
        case .buildingType:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.house.buildingType.rawValue
            )
        case .hasFences:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.house.hasFences.toLocalizedString()
            )
        case .hasOutdoorYard:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.house.hasOutdoorYard.toLocalizedString()
            )
        case .houseAreaSize:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: "\(adopter.house.areaSize) m²"
            )
        case .animalStayInfo:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.house.animalStayInfo
            )
        case .currentPetsAmount:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.pets.amount.current.description
            )
        case .ownedPetsAmount:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.pets.amount.owned.description
            )
        case .currentPetsInfo:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.pets.info ?? "-"
            )
        case .petsVaccinationStatus:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.pets.vaccinationStatus?.rawValue ?? "-"
            )
        case .petCareLocationInfo:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.petCare.location ?? "-"
            )
        case .knownPetCare:
            let knownPetCare = adopter.petCare.known?
                .compactMap { $0.rawValue }
                .joined(separator: " & ")
            
            cell.setSubtitleCell(
                title: row.rawValue,
                value: knownPetCare ?? "-"
            )
        case .clinicName:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.petCare.clinic?.name ?? "-"
            )
        case .clinicAddress:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.petCare.clinic?.address ?? "-"
            )
        case .veterinaryName:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.petCare.veterinary?.name ?? "-"
            )
        case .veterinaryPhoneNumber:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.petCare.veterinary?.phoneNumber ?? "-"
            )
        case .hasBackupKeeper:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.petCare.hasBackupKeeper ? "Ada" : "Tidak Ada"
            )
        case .backupKeeperContactInformation:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.petCare.backupKeeperInfo ?? "-"
            )
        case .experienceLevel:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.experience.level.rawValue
            )
        case .experienceOwningPets:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.experience.owningPets.toDateString()
            )
        case .animalsToAdopt:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.preferences.animal?.name ?? "-"
            )
        case .reasonChoosingAnimals:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.preferences.animal?.reason ?? "-"
            )
        case .animalTypePreference:
            let typePreferences = adopter.preferences.type?.values
                .compactMap { $0.rawValue }
                .joined(separator: " & ")
            
            cell.setSubtitleCell(
                title: row.rawValue,
                value: typePreferences ?? "-"
            )
        case .detailedAnimalTypePreference:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.preferences.type?.details ?? "-"
            )
        case .animalTypePreferenceReason:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.preferences.type?.reason ?? "-"
            )
        case .animalStylePreference:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.preferences.style?.value ?? "-"
            )
        case .animalStylePreferenceReason:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.preferences.style?.reason ?? "-"
            )
        case .animalCharacterPreference:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.preferences.character?.value ?? "-"
            )
        case .animalCharacterPreferenceReason:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.preferences.character?.reason ?? "-"
            )
        case .animalGenderPreference:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.preferences.gender?.value.rawValue ?? "-"
            )
        case .animalGenderPreferenceReason:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.preferences.gender?.reason ?? "-"
            )
        case .status:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: adopter.form.status,
                editable: true
            )
        default: break
        }
    }
}
