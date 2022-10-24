//
//  TrackInfoViewController.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 23/10/2022.
//

import UIKit

class TrackInfoViewController: UIViewController {
    var onDisplayBlock: ((_ isVisible: Bool, _ sheetHeight: Double) -> Void)?
    private var interactor: TrackInfoInteractor
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrackInfoTableViewCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(interactor: TrackInfoInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        interactor.delegate = self
        
        addComponents()
        layoutComponents()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        onDisplayBlock?(true, view.frame.height)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        onDisplayBlock?(false, 0)
    }
    
    private func addComponents() {
        view.addSubview(tableView)
    }
    
    private func layoutComponents() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension TrackInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(TrackInfoTableViewCell.self, for: indexPath)
        cell.configure(with: interactor.viewModel.items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Track info"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

extension TrackInfoViewController: TrackInfoInteractorDelegate {
    func interactorDidUpdateViewModel(_ viewModel: TrackInfoViewModel) {
        tableView.reloadData()
    }
}
