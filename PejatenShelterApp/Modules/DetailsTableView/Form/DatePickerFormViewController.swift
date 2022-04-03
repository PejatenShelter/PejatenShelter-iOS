//
//  DatePickerFormViewController.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 28/05/22.
//

import UIKit

final class DatePickerFormViewController: UIViewController {
    @IBOutlet private weak var overlayView: UIView!
    @IBOutlet private weak var modalStackView: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateField: UITextField!
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChanged), for: .allEvents)
        return datePicker
    }()
    
    var dismissAction: () -> Void = {}
    var saveAction: (String) -> Void = { _ in }
    
    private var formTitle: String?
    private var formValue: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews() {
        titleLabel.text = formTitle
        dateField.text = formValue?.toLocalizedString()
        overlayView.isHidden = true
        setupTextField()
        setupModalRoundedCorners()
    }
    
    private func setupModalRoundedCorners() {
        modalStackView.clipsToBounds = true
        modalStackView.layer.cornerRadius = 8
        modalStackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupTextField() {
        dateField.inputView = datePicker
        dateField.tintColor = .clear
        dateField.delegate = self
    }
    
    func setup(
        title: String,
        value: String
    ) {
        formTitle = title
        guard let dateValue = value.toDate() else { return }
        
        formValue = dateValue
        datePicker.date = dateValue
    }
    
    @IBAction func didTapPicker(_ sender: UIButton) {
        dateField.becomeFirstResponder()
    }
    
    @IBAction func didTapOutside(_ sender: UIButton) {
        dismissAction()
    }
    
    @IBAction func didTapCancelButton(_ sender: UIButton) {
        dismissAction()
    }
    
    @IBAction func didTapFinishButton(_ sender: UIButton) {
        guard let dobString = formValue?.toDobString() else { return }
        saveAction(dobString)
        dismissAction()
    }
    
    @objc func dateChanged() {
        formValue = datePicker.date
        dateField.text = formValue?.toLocalizedString()
    }
}

extension DatePickerFormViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        overlayView.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        overlayView.isHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
