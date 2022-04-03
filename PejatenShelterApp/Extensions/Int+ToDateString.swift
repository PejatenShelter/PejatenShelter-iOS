//
//  Int+ToDateString.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 16/05/22.
//

import Foundation

extension Month {
    func toDateString() -> String {
        var dateString = ""
        if self / 12 > 0 && self % 12 > 0 {
            dateString.append("\(self/12) Tahun \(self%12) Bulan")
            
        }
        else if self / 12 > 0 { dateString.append("\(self/12) Tahun") }
        else if self % 12 > 0 { dateString.append("\(self%12) Bulan")}
        return dateString
    }
}
