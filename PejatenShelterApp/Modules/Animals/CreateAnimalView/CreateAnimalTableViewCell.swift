//
//  CreateAnimalTableViewCell.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 29/05/22.
//

import UIKit

struct CreateAnimalTableViewCell {
    private init() {}
    
    static func make(
        for row: CreateAnimalViewModel.Row,
        in tableView: UITableView,
        at indexPath: IndexPath,
        with animal: CreateAnimalModel
    ) -> UITableViewCell {
        let cell = cell(for: row, in: tableView, at: indexPath)
        cell.backgroundColor = .systemBackground
        setup(cell: cell, for: row, with: animal)
        return cell
    }
    
    private static func cell(
        for row: CreateAnimalViewModel.Row,
        in tableView: UITableView,
        at indexPath: IndexPath
    ) -> UITableViewCell {
        switch row {
        case .name,
                .sex,
                .type,
                .dob,
                .breed,
                .status,
                .healthStatus,
                .specialCondition:
            return tableView.dequeueReusableCell(
                withIdentifier: SubtitleTableViewCell.identifier,
                for: indexPath
            )
        case .photo:
            return tableView.dequeueReusableCell(
                withIdentifier: DefaultTableViewCell.identifier,
                for: indexPath
            )
        }
    }
    
    private static func setup(
        cell: UITableViewCell,
        for row: CreateAnimalViewModel.Row,
        with animal: CreateAnimalModel
    ) {
        switch row {
        case .name:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: animal.name,
                editable: true
            )
        case .photo:
            cell.setDefaultCell(with: row.rawValue)
        case .sex:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: animal.sex,
                editable: true
            )
        case .type:
            let type = animal.type
            cell.setSubtitleCell(
                title: row.rawValue,
                value: type,
                editable: true
            )
        case .breed:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: animal.breed,
                editable: true
            )
        case .dob:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: animal.dobString
                    .toDate()?.toLocalizedString() ?? "-",
                editable: true
            )
        case .status:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: animal.status,
                editable: true
            )
        case .healthStatus:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: animal.healthStatus,
                editable: true
            )
        case .specialCondition:
            cell.setSubtitleCell(
                title: row.rawValue,
                value: animal.specialCondition,
                editable: true
            )
        }
    }
}
