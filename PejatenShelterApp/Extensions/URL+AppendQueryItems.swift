//
//  URL+AppendQueryItems.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 03/05/22.
//

import Foundation

extension URL {
    func appending(_ queryItem: String, value: String?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString)
        else { return absoluteURL }

        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        queryItems.append(.init(name: queryItem, value: value))
        urlComponents.queryItems = queryItems

        return urlComponents.url!
    }
}
