//
//  CreateAnimalViewController.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 29/05/22.
//

import UIKit
import SwinjectStoryboard

final class CreateAnimalViewController: UITableViewController {
    
    private var viewModel = SwinjectStoryboard.defaultContainer
        .resolve(CreateAnimalViewModel.self)!
    
    private var saveAction: (Animal) -> Void = { _ in }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews() {
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        setupTableView()
        setupNavigation()
    }
    private func setupTableView() {
        tableView.registerDefaultCells()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 48
    }
    
    private func setupNavigation() {
        navigationItem.rightBarButtonItem = .init(
            title: "Simpan",
            style: .done,
            target: self,
            action: #selector(didTapSaveButton)
        )
    }
    
    @objc func didTapSaveButton() {
        viewModel.createAnimal { [weak self] result in
            switch result {
            case .success(let newAnimal):
                DispatchQueue.main.async {
                    self?.saveAction(newAnimal)
                    self?.navigationController?
                        .popViewController(animated: true)
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.navigationController?
                        .popViewController(animated: true)
                }
            }
        }
    }

    
    func setup(saveAction: @escaping (Animal) -> Void) {
        self.saveAction = saveAction
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = viewModel.getRow(
            rowIndex: indexPath.row
        ) else { return .init() }
        
        return CreateAnimalTableViewCell.make(
            for: row, in: tableView, at: indexPath, with: viewModel.animal
        )
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = viewModel.getRow(
            rowIndex: indexPath.row
        ) else { return }
        
        let animal = viewModel.animal
        switch row {
        case .name:
            showTextField(
                title: row.rawValue,
                value: animal.name
            ) { [weak animal] name in
                animal?.name = name
            }
        case .photo:
            showPhotoImagePicker(
                image: animal.photo
            ) { [weak animal] image in
                animal?.photo = image
            }
        case .sex:
            showPicker(
                title: row.rawValue,
                value: animal.sex,
                values: Animal.Sex.allCases.map { $0.rawValue }
            ) { [weak animal] sex in
                animal?.sex = sex
            }
        case .type:
            showPicker (
                title: row.rawValue,
                value: animal.type,
                values: Animal.Species.allCases.map { $0.rawValue }
            ) { [weak animal] type in
                animal?.type = type
            }
        case .breed:
            showTextField(
                title: row.rawValue,
                value: animal.breed
            ) { [weak animal] breed in
                animal?.breed = breed
            }
        case .dob:
            showDateOfBirthPicker(
                title: "Tanggal Lahir",
                value: animal.dobString
            ) { [weak animal] birthDate in
                animal?.dobString = birthDate
            }
        case .healthStatus:
            showPicker(
                title: row.rawValue,
                value: animal.healthStatus,
                values: Animal.HealthStatus.allCases.map { $0.rawValue }
            ) { [weak animal] healthStatus in
                animal?.healthStatus = healthStatus
            }
        case .specialCondition:
            showTextView(
                title: row.rawValue,
                value: animal.specialCondition
            ) { [weak animal] specialCondition in
                animal?.specialCondition =
                    specialCondition.isEmpty ? "Tidak ada" : specialCondition
            }
        case .status:
            showPicker(
                title: row.rawValue,
                value: animal.status,
                values: Animal.AdoptionStatus.allCases.map { $0.rawValue }
            ) { [weak animal] status in
                animal?.status = status
            }
        }
    }
    
    private func showTextField(
        title: String,
        value: String,
        completeAction: @escaping (String) -> ()
    ) {
        let textFieldVC = TextFieldFormViewController()
        textFieldVC.dismissAction = { [weak self] in
            self?.dismiss(animated: true)
        }
        textFieldVC.saveAction = { [weak self] value in
            completeAction(value)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        textFieldVC.setup(title: title, value: value)
        present(textFieldVC, animated: true)
    }
    
    private func showTextView(
        title: String,
        value: String,
        completeAction: @escaping (String) -> ()
    ) {
        let textViewVC = TextViewFormViewController()
        textViewVC.dismissAction = { [weak self] in
            self?.dismiss(animated: true)
        }
        textViewVC.saveAction = { [weak self] value in
            completeAction(value)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        textViewVC.setup(title: title, value: value)
        present(textViewVC, animated: true)
    }
    
    private func showPhotoImagePicker(
        image: UIImage?,
        completeAction: @escaping (UIImage) -> ()
    ) {
        let imagePickerVC = ImagePickerFormViewController()
        imagePickerVC.dismissAction = { [weak self] in
            self?.dismiss(animated: true)
        }
        imagePickerVC.saveAction = { [weak self] value in
            completeAction(value)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        imagePickerVC.setup(image: image)
        present(imagePickerVC, animated: true)
    }
    
    private func showPicker(
        title: String,
        value: String,
        values: [String],
        completeAction: @escaping (String) -> ()
    ) {
        let pickerVC = PickerFormViewController()
        pickerVC.dismissAction = { [weak self] in
            self?.dismiss(animated: true)
        }
        pickerVC.saveAction = { [weak self] value in
            completeAction(value)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        pickerVC.setup(title: title, value: value, values: values)
        present(pickerVC, animated: true)
    }
    
    private func showDateOfBirthPicker(
        title: String,
        value: String,
        completeAction: @escaping (String) -> ()
    ) {
        let datePickerVC = DatePickerFormViewController()
        datePickerVC.dismissAction = { [weak self] in
            self?.dismiss(animated: true)
        }
        datePickerVC.saveAction = { [weak self] value in
            completeAction(value)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        datePickerVC.setup(title: title, value: value)
        present(datePickerVC, animated: true)
    }
}
