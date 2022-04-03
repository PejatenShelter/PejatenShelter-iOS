//
//  AnimalDetailsViewController.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 16/05/22.
//

import UIKit
import Kingfisher
import SwinjectStoryboard

final class AnimalDetailsViewController: UITableViewController {
    
    private var viewModel = SwinjectStoryboard.defaultContainer
        .resolve(AnimalDetailsViewModel.self)!
    
    private var saveAction: () -> Void = { }
        
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
        guard let animal = viewModel.updatedAnimal else { return }
        update(animal)
    }
    
    func setup(with animal: Animal, saveAction: @escaping () -> Void) {
        viewModel.set(animal: animal)
        navigationItem.title = animal.name
        tableView.reloadData()
        self.saveAction = saveAction
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getSectionRowCount(for: section)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CollapsibleHeaderView(
            frame: .init(
                x: 0, y: 0,
                width: tableView.frame.width,
                height: 48
            )
        )
        
        headerView.setup(
            title: viewModel.getSectionTitle(for: section),
            isOpen: viewModel.isOpen(for: section)
        ) { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.openHeader(for: section)
            }
        }
        
        tableView.reloadSections(
            .init(integer: section), with: .none
        )
        
        return headerView
    }
    
    private func openHeader(for index: Int) {
        if viewModel.isOpen(for: index) {
            let rowCount = viewModel.getSectionRowCount(for: index)
            let indexes = (0..<rowCount).map { IndexPath(row: $0, section: index) }
            viewModel.toggleIsOpen(for: index)
            tableView.deleteRows(at: indexes, with: .fade)
        } else {
            viewModel.toggleIsOpen(for: index)
            let rowCount = viewModel.getSectionRowCount(for: index)
            let indexes = (0..<rowCount).map { IndexPath(row: $0, section: index) }
            tableView.insertRows(at: indexes, with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = viewModel.getRow(
            sectionIndex: indexPath.section,
            rowIndex: indexPath.row
        ), let animal = viewModel.updatedAnimal else { return .init() }
        
        return AnimalDetailsTableViewCell.make(
            for: row, in: tableView, at: indexPath, with: animal
        )
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = viewModel.getRow(
            sectionIndex: indexPath.section,
            rowIndex: indexPath.row
        ), let animal = viewModel.updatedAnimal else { return }
        
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
                image: animal.selectedImage
            ) { [weak animal] image in
                animal?.selectedImage = image
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
                value: animal.breed ?? ""
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
        default: break
        }
    }
    
    func update(_ animal: Animal) {
        // TODO: Add Loading Animation Here
        viewModel.animal?.copyValues(from: viewModel.updatedAnimal)
        viewModel.update(animal: animal) { [weak self] result in
            // TODO: Handle Error
            DispatchQueue.main.async {
                self?.navigationController?
                    .popViewController(animated: true)
                self?.saveAction()
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
