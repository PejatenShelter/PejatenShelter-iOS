//
//  DefaultsWrapper.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 03/04/22.
//

import Foundation

@propertyWrapper
struct Defaults<Value> {
    let key: String
    let defaultValue: Value
    let container: UserDefaults = .standard
    
    var wrappedValue: Value {
        get {
            container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}
