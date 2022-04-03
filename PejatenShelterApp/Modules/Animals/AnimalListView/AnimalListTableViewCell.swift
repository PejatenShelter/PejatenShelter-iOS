//
//  AnimalListTableViewCell.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 04/05/22.
//

import UIKit
import Kingfisher

final class AnimalListTableViewCell: UITableViewCell {
    static let identifier = "AnimalListTableViewCell"
    
    private var animal: Animal?
    
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var breedLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var adoptionStatusLabel: UILabel!
    
    func setup(with animal: Animal) {
        nameLabel.text = animal.name
        ageLabel.text = animal.ageString
        breedLabel.text = animal.breed ?? "-"
        setupImageView(with: animal.photo?.first?.thumbnails?.large.urlString)
        setupStatusTag(with: animal.status)
        self.animal = animal
    }
    
    private func setupImageView(with urlString: String?) {
        photoImageView.kf.indicatorType = .activity
        photoImageView.kf.setImage(
            with: URL(string: urlString ?? ""),
            placeholder: R.image.placeholderImage()
        ) { [weak self] result in
            switch result {
            case .success(let kfImage):
                self?.animal?.selectedImage = kfImage.image
            default: break
            }
        }
        photoImageView.layer.cornerRadius = 16
    }
    
    private func setupStatusTag(with status: String) {
        adoptionStatusLabel.text = status
        switch status {
        case Animal.AdoptionStatus.adopted.rawValue:
            adoptionStatusLabel.textColor = .systemPink
        case Animal.AdoptionStatus.available.rawValue:
            adoptionStatusLabel.textColor = .systemBlue
        case Animal.AdoptionStatus.notAvailable.rawValue:
            adoptionStatusLabel.textColor = .systemGray
        default: break
        }
    }
}
