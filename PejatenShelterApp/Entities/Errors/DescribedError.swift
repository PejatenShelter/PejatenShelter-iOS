//
//  DescribedError.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 02/05/22.
//

import Foundation
protocol DescribedError: CustomStringConvertible {
    var description: String { get }
}
