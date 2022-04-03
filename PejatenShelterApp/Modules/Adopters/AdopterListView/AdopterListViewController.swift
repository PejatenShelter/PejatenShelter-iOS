//
//  AdopterListViewController.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 15/04/22.
//

import UIKit
import SwinjectStoryboard

final class AdopterListViewController: UIViewController {
    enum Segment {
        case ongoing
        case finished
        case complete
        
        init?(index: Int) {
            switch index {
            case 0: self = .ongoing
            case 1: self = .finished
            case 2: self = .complete
            default: return nil
            }
        }
        
        func filter() -> DatabaseFilter {
            switch self {
            case .ongoing: return .adopterOngoing
            case .finished: return .adopterFinished
            case .complete: return .adopterComplete
            }
        }
    }
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var topActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var bottomActivityIndicator: UIActivityIndicatorView!
    
    private var selectedSegment: Segment = .ongoing
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self, action: #selector(refreshAdopters), for: .valueChanged
        )
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel
        ]
        refreshControl.attributedTitle = .init(
            string: "Memuat adopter...", attributes: attributes)
        
        return refreshControl
    }()
    
    private var viewModel = SwinjectStoryboard.defaultContainer
        .resolve(AdopterListViewModel.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
        fetchAdopters()
    }
    
    private func setupNavigation() {
        navigationItem.title = "Form Adopsi"
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        guard let selectedSegment = Segment(index: sender.selectedSegmentIndex)
        else { return }
        self.selectedSegment = selectedSegment
        refreshAdopters()
    }
    
}

// MARK: - Fetch Adopter Data

extension AdopterListViewController {
    @objc private func refreshAdopters() {
        fetchAdopters()
    }
    
    func fetchAdopters() {
        refreshControl.beginRefreshing()
        viewModel.fetchAdopters(segment: selectedSegment) { [weak self] result in
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
    
    func fetchMoreAdopters() {
        bottomActivityIndicator.startAnimating()
        viewModel.fetchMoreAdopters(segment: selectedSegment) { [weak self] result in
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

extension AdopterListViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        registerCells()
        tableView.refreshControl = refreshControl
    }
    
    private func registerCells() {
        tableView.register(
            UINib(resource: R.nib.adopterListTableViewCell),
            forCellReuseIdentifier: AdopterListTableViewCell.identifier
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getAdoptersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AdopterListTableViewCell.identifier,
            for: indexPath
        ) as? AdopterListTableViewCell else { return .init() }
        
        if let adopter = viewModel.getAdopter(for: indexPath.row) {
            cell.setup(with: adopter)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        openDetailsView(for: indexPath.row)
    }
    
    private func openDetailsView(for index: Int) {
        guard let adopter = viewModel.getAdopter(for: index) else { return }
        
        let detailVC = AdopterDetailsViewController()
        detailVC.setup(with: adopter) { [weak self] in
            self?.fetchAdopters()
            self?.tableView.reloadData()
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row > tableView.numberOfRows(inSection: 0) - 2
        else { return }
        fetchMoreAdopters()
    }
    
}
