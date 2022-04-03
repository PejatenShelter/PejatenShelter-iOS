//
//  UITableView+RegisterDefaultCells.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 28/05/22.
//

import UIKit

extension UITableView {
    func registerDefaultCells() {
        register(
            SubtitleTableViewCell.self,
            forCellReuseIdentifier: SubtitleTableViewCell.identifier
        )
        register(
            DefaultTableViewCell.self,
            forCellReuseIdentifier: DefaultTableViewCell.identifier
        )
        register(
            ValueTableViewCell.self,
            forCellReuseIdentifier: ValueTableViewCell.identifier
        )
    }
}
