//
//  FirebaseStorageAdapter.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 29/05/22.
//

import UIKit

struct FirebaseStorageAdapter: ImageUploadService {
    func upload(image: UIImage, completion: @escaping (Result<String,Error>) -> Void) {
        // TODO: Implement Image Upload Here
        completion(.success("https://i.ibb.co/dWtwFXp/placeholder-Image.png"))
    }
}
