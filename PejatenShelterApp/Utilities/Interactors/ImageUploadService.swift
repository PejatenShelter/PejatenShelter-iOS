//
//  ImageUploadService.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 29/05/22.
//

import UIKit

protocol ImageUploadService {
    func upload(image: UIImage, completion: @escaping (Result<String,Error>) -> Void)
}
