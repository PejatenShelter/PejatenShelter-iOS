//
//  CreateAnimalModel.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 29/05/22.
//

import UIKit
import Rswift

final class CreateAnimalModel {
    var name: String
    var photo: UIImage?
    var urlString: String
    var breed: String
    var dobString: String
    var type: String
    var sex: String
    var healthStatus: String
    var specialCondition: String
    var status: String
    
    init(
        name: String = "Masukkan Nama",
        photo: UIImage? = nil,
        urlString: String = "https://i.ibb.co/dWtwFXp/placeholder-Image.png",
        breed: String = "Masukkan Breed",
        dobString: String = Date.now.toDobString(),
        type: String = "Anjing",
        sex: String = "Laki-laki",
        healthStatus: String = "Divaksin",
        specialCondition: String = "Tidak ada",
        status: String = "Tersedia untuk Diadopsi"
    ) {
        self.name = name
        self.photo = photo
        self.urlString = urlString
        self.breed = breed
        self.dobString = dobString
        self.type = type
        self.sex = sex
        self.healthStatus = healthStatus
        self.specialCondition = specialCondition
        self.status = status
    }
    
    init(animal: CreateAnimalModel) {
        name = animal.name
        photo = animal.photo
        urlString = animal.urlString
        breed = animal.breed
        dobString = animal.dobString
        type = animal.type
        sex = animal.sex
        healthStatus = animal.healthStatus
        specialCondition = animal.specialCondition
        status = animal.status
    }
    
    func copyValues(from animal: CreateAnimalModel?) {
        guard let animal = animal else { return }
        name = animal.name
        photo = animal.photo
        urlString = animal.urlString
        breed = animal.breed
        dobString = animal.dobString
        type = animal.type
        sex = animal.sex
        healthStatus = animal.healthStatus
        specialCondition = animal.specialCondition
        status = animal.status
    }
}
