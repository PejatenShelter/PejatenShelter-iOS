//
//  NavigationError.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 02/05/22.
//

import Foundation

enum NavigationError: Error {
    case windowNotFound
    case navigationControllerNotFound
    case viewControllerNotFound
    case unknown
}

extension NavigationError: DescribedError {
    public var description: String {
        switch self {
        case .windowNotFound:
            return "Error: Window Not Found"
        case .navigationControllerNotFound:
            return "Error: Navigation Controller Not Found"
        case .viewControllerNotFound:
            return "Error: View Controller Not Found"
        case .unknown:
            return "Unknown Error"
        }
    }
}
