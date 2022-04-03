//
//  TextViewFormViewController.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 29/05/22.
//

import UIKit

final class TextViewFormViewController: UIViewController, AlertDisplaying {

    @IBOutlet private weak var modalStackView: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textView: UITextView!
    
    var dismissAction: () -> Void = {}
    var saveAction: (String) -> Void = { _ in }
    
    private var formTitle: String?
    private var formValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews() {
        titleLabel.text = formTitle
        textView.text = formValue
        setupModalRoundedCorners()
        setupTextViewBorder()
    }
    
    private func setupTextViewBorder() {
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    private func setupModalRoundedCorners() {
        modalStackView.clipsToBounds = true
        modalStackView.layer.cornerRadius = 8
        modalStackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setup(title: String, value: String) {
        formTitle = title
        formValue = value
    }
    
    
    @IBAction func didTapOutside(_ sender: UIButton) {
        dismissAction()
    }
    
    @IBAction func didTapCancelButton(_ sender: UIButton) {
        dismissAction()
    }
    
    @IBAction func didTapFinishButton(_ sender: UIButton) {
        guard let text = textView.text,
              !text.isEmpty
        else {
            displayAlert(
                title: "Gagal Menyimpan",
                message: "Kolom tidak boleh dikosongan, mohon diisi atau tekan tombol Batal",
                actions: .ok()
            )
            return
        }
        
        saveAction(text)
        dismissAction()
    }
}
