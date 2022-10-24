//
//  TracksViewController.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 19/10/2022.
//

import UIKit
import MapKit
import CoreLocation

protocol TracksViewControllerDelegate: AnyObject {
    func viewControllerWantsToShowTrackDetail(_ viewController: TracksViewController, track: Track)
}

class TracksViewController: UIViewController {
    weak var delegate: TracksViewControllerDelegate?
    private var interactor: TracksInteractor
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrackTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(interactor: TracksInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addComponents()
        layoutComponents()
        interactor.delegate = self
        interactor.load()
    }
    
    private func addComponents() {
        view.addSubview(tableView)
    }
    
    private func layoutComponents() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension TracksViewController: TracksInteractorDelegate {
    func interactorDidUpdateViewModel(_ viewModel: TracksViewModel) {
        tableView.reloadData()
    }
}

extension TracksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(TrackTableViewCell.self, for: indexPath)
        cell.configure(with: interactor.viewModel.items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedTrack = interactor.viewModel.tracks[indexPath.row]
        delegate?.viewControllerWantsToShowTrackDetail(self, track: selectedTrack)
    }
}
