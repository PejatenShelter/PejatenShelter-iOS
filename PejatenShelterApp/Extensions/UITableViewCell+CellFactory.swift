//
//  UITableViewCell+CellFactory.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 16/05/22.
//

import UIKit

extension UITableViewCell {
    func setDefaultCell(with text: String)  {
        accessoryType = .disclosureIndicator
        backgroundColor = .systemBackground
        
        var content = defaultContentConfiguration()
        content.attributedText = try? .init(markdown: "**\(text)**")
        
        contentConfiguration = content
        selectionStyle = .none
    }
    
    func setValueCell(
        title: String,
        value: String,
        editable: Bool = false
    ) {
        accessoryType = editable ? .disclosureIndicator : .none
        backgroundColor = .systemBackground
        
        var content = defaultContentConfiguration()
        content.attributedText = try? .init(markdown: "**\(title)**")
        content.secondaryAttributedText = try? .init(markdown: "\(value)")
        
        contentConfiguration = content
        selectionStyle = .none
    }
    
    func setSubtitleCell(
        title: String,
        value: String,
        editable: Bool = false
    ) {
        accessoryType = editable ? .disclosureIndicator : .none
        backgroundColor = .systemBackground
        
        var content = defaultContentConfiguration()
        content.attributedText = try? .init(markdown: "**\(title)**")
        content.secondaryAttributedText = try? .init(markdown: "\(value)")
        content.secondaryTextProperties.numberOfLines = 0
        content.secondaryTextProperties.lineBreakMode = .byTruncatingTail
        
        contentConfiguration = content
        selectionStyle = .none
    }
}
