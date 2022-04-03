//
//  Date+ToDobString.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 02/05/22.
//

import Foundation

typealias Year = Int
typealias Month = Int
typealias Day = Int


extension Date {
    func toDobString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    func toLocalizedString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: self)
    }
    
    func toAgeInMonths() -> Int {
        let dateComponent = Calendar.current.dateComponents(
            [.year, .month, .day], from: self, to: .now)
        return (dateComponent.year! * 12) + dateComponent.month!
    }
}

extension String {
    func toDate(with format: String? = nil) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format == nil ? "yyyy-MM-dd" : format
        return formatter.date(from: self)
    }
}
