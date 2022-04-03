//
//  AdopterDetailsViewController.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 16/05/22.
//

import UIKit
import SwinjectStoryboard

final class AdopterDetailsViewController: UITableViewController {
    
    private var viewModel = SwinjectStoryboard.defaultContainer
        .resolve(AdopterDetailsViewModel.self)!
    
    private var saveAction: () -> Void = { }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        setupTableView()
        setupNavigation()
    }
    
    func setup(with adopter: Adopter, saveAction: @escaping () -> Void) {
        viewModel.set(adopter: adopter)
        navigationItem.title = adopter.info.name
        tableView.reloadData()
        self.saveAction = saveAction
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
        guard let record = viewModel.updatedAdopter?.record else { return }
        update(record)
    }
    
    func update(_ adopter: AdopterRecord) {
        // TODO: Add Loading Animation Here
        viewModel.adopter?
            .changeStatus(to: viewModel.updatedAdopter?.form.status)
        viewModel.update(adopter: adopter) { [weak self] result in
            // TODO: Handle Error
            DispatchQueue.main.async {
                self?.navigationController?
                    .popViewController(animated: true)
                self?.saveAction()
            }
        }
    }
    
    // MARK: - Table View Data Source

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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = viewModel.getRow(
            sectionIndex: indexPath.section,
            rowIndex: indexPath.row
        ), let adopter = viewModel.updatedAdopter else { return .init() }
        
        return AdopterDetailsTableViewCell.make(
            for: row, in: tableView, at: indexPath, with: adopter
        )
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = viewModel.getRow(
            sectionIndex: indexPath.section,
            rowIndex: indexPath.row
        ), let adopter = viewModel.updatedAdopter else { return }
        
        switch row {
        case .status:
            showPicker(
                title: row.rawValue,
                value: adopter.form.status,
                values: Adopter.FormStatus.allCases.map { $0.rawValue }
            ) { [weak adopter] status in
                adopter?.changeStatus(to: status)
            }
        default: return
        }
    }
    
    func reloadTable() {
        tableView.reloadData()
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
}
