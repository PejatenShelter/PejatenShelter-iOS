//
//  AdopterListTableViewCell.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 04/05/22.
//

import UIKit

final class AdopterListTableViewCell: UITableViewCell {
    static let identifier = "AdopterListTableViewCell"
    
    @IBOutlet private weak var adopterNameLabel: UILabel!
    @IBOutlet private weak var formStatusLabel: UILabel!
    
    func setup(with adopter: Adopter) {
        adopterNameLabel.text = adopter.info.name
        setupStatusTag(with: adopter.form.status)
    }
    
    private func setupStatusTag(with status: String) {
        formStatusLabel.text = status
        switch status {
        case Adopter.FormStatus.formSubmission.rawValue:
            formStatusLabel.textColor = .systemBlue
        case Adopter.FormStatus.interview.rawValue:
            formStatusLabel.textColor = .systemTeal
        case Adopter.FormStatus.houseSurvey.rawValue:
            formStatusLabel.textColor = .systemPink
        case Adopter.FormStatus.canceled.rawValue:
            formStatusLabel.textColor = .systemGray
        case Adopter.FormStatus.rejected.rawValue:
            formStatusLabel.textColor = .systemRed
        case Adopter.FormStatus.accepted.rawValue:
            formStatusLabel.textColor = .systemGreen
        default: break
        }
    }
}
