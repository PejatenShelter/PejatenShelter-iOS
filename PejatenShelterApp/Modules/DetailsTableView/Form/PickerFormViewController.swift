//
//  PickerFormViewController.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 28/05/22.
//

import UIKit

final class PickerFormViewController: UIViewController {

    @IBOutlet private weak var overlayView: UIView!
    @IBOutlet private weak var modalStackView: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var pickerField: UITextField!
    
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    var dismissAction: () -> Void = {}
    var saveAction: (String) -> Void = { _ in }
    
    private var formTitle: String?
    private var formValue: String?
    private var values = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews() {
        titleLabel.text = formTitle
        pickerField.text = formValue
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
        pickerField.inputView = pickerView
        pickerField.tintColor = .clear
        pickerField.delegate = self
    }
    
    func setup(
        title: String,
        value: String,
        values: [String]
    ) {
        formTitle = title
        formValue = value
        self.values = values
        pickerView.selectRow(
            values.firstIndex { $0 == value } ?? 0,
            inComponent: 0,
            animated: false
        )
    }
    
    @IBAction func didTapPicker(_ sender: UIButton) {
        pickerField.becomeFirstResponder()
    }
    
    @IBAction func didTapOutside(_ sender: UIButton) {
        dismissAction()
    }
    
    @IBAction func didTapCancelButton(_ sender: UIButton) {
        dismissAction()
    }
    
    @IBAction func didTapFinishButton(_ sender: UIButton) {
        guard let value = formValue else { return }
        saveAction(value)
        dismissAction()
    }
}

extension PickerFormViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        values[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        formValue = values[row]
        pickerField.text = formValue
    }
}

extension PickerFormViewController: UITextFieldDelegate {
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
