//
//  CreateAnimalViewModel+TableRows.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 29/05/22.
//

import Foundation

extension CreateAnimalViewModel {
    enum Row: String {
        case name = "Nama"
        case photo = "Foto"
        case sex = "Jenis Kelamin"
        case type = "Jenis Anabul"
        case breed = "Jenis Breed"
        case dob = "Tanggal Lahir"
        case healthStatus = "Status Kesehatan"
        case specialCondition = "Kondisi Khusus"
        case status = "Status Adopsi"
    }
}
