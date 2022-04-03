//
//  CollapsibleHeaderView.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 16/05/22.
//

import UIKit

final class CollapsibleHeaderView: UIView {
    
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var sectionTitleLabel: UILabel!
    @IBOutlet private weak var chevronImageView: UIImageView!
    
    var isOpen: Bool = false {
        didSet {
            chevronImageView.image = isOpen ?
                UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
        }
    }
    var tapAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    private func initSubviews() {
        let nib = UINib(resource: R.nib.collapsibleHeaderView)
        nib.instantiate(withOwner: self, options: nil)
        headerView.frame = self.frame
        addSubview(headerView)
    }
    
    func setup(title: String, isOpen: Bool, tapAction: @escaping () -> Void) {
        sectionTitleLabel.text = title
        self.isOpen = isOpen
        self.tapAction = tapAction
    }
    
    @IBAction func didTapHeader(_ sender: UIButton) {
        tapAction?()
        isOpen.toggle()
    }
    
}
