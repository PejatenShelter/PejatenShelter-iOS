//
//  Bool+ToLocalizedString.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 16/05/22.
//

import Foundation

extension Bool {
    func toLocalizedString() -> String {
        return self ? "Ya" : "Tidak"
    }
}
