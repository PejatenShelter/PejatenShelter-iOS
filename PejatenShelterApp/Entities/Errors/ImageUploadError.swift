//
//  ImageUploadError.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 29/05/22.
//

import Foundation

enum ImageUploadError: Error, Equatable {
    case networkError
    case photoIsNil
    case unknown
}
