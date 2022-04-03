//
//  AnimalListViewController.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 15/04/22.
//

import UIKit
import Rswift
import SwinjectStoryboard

final class AnimalListViewController: UIViewController {
    enum Segment {
        case availableToAdopt
        case complete
        
        init?(index: Int) {
            switch index {
            case 0: self = .availableToAdopt
            case 1: self = .complete
            default: return nil
            }
        }
        
        func filter() -> DatabaseFilter {
            switch self {
            case .availableToAdopt: return .animalAvailableToAdopt
            case .complete: return .animalComplete
            }
        }
    }
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var topActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var bottomActivityIndicator: UIActivityIndicatorView!
    
    private var selectedSegment: Segment = .availableToAdopt
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self, action: #selector(refreshAnimals), for: .valueChanged
        )
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel
        ]
        refreshControl.attributedTitle = .init(
            string: "Memuat hewan...", attributes: attributes)
        
        return refreshControl
    }()
    
    private var viewModel = SwinjectStoryboard.defaultContainer
        .resolve(AnimalListViewModel.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
        fetchAnimals()
    }
    
    private func setupNavigation() {
        navigationItem.title = "Daftar Hewan"
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAddButton)
        )
    }
    
    @objc func didTapAddButton() {
        openCreateAnimalView()
    }
    
    private func openCreateAnimalView() {
        let detailVC = CreateAnimalViewController()
        detailVC.setup { [weak self] animal in
            print("@@@ \(animal)")
            self?.viewModel.append(animal: animal)
            self?.tableView.reloadData()
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        guard let selectedSegment = Segment(index: sender.selectedSegmentIndex)
        else { return }
        self.selectedSegment = selectedSegment
        refreshAnimals()
    }
    
}

// MARK: - Fetch Animal Data

extension AnimalListViewController {
    @objc private func refreshAnimals() {
        fetchAnimals()
    }
    
    private func fetchAnimals() {
        refreshControl.beginRefreshing()
        viewModel.fetchAnimals(segment: selectedSegment) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            case .failure:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    private func fetchMoreAnimals() {
        bottomActivityIndicator.startAnimating()
        viewModel.fetchMoreAnimals(segment: selectedSegment) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.bottomActivityIndicator.stopAnimating()
                }
            case .failure:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self?.bottomActivityIndicator.stopAnimating()
                }
            }
        }
    }
}

// MARK: - Setup Table View

extension AnimalListViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        registerCells()
        tableView.refreshControl = refreshControl
    }
    
    private func registerCells() {
        tableView.register(
            UINib(resource: R.nib.animalListTableViewCell),
            forCellReuseIdentifier: AnimalListTableViewCell.identifier
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getAnimalsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AnimalListTableViewCell.identifier,
            for: indexPath
        ) as? AnimalListTableViewCell else { return .init() }
        
        if let animal = viewModel.getAnimal(for: indexPath.row) {
            cell.setup(with: animal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        openDetailsView(for: indexPath.row)
    }
    
    private func openDetailsView(for index: Int) {
        guard let animal = viewModel.getAnimal(for: index) else { return }
        
        let detailVC = AnimalDetailsViewController()
        detailVC.setup(with: animal) { [weak self] in
            self?.fetchAnimals()
            self?.tableView.reloadData()
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row > tableView.numberOfRows(inSection: 0) - 2
        else { return }
        fetchMoreAnimals()
    }
    
}
