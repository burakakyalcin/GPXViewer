//
//  TrackTableViewCell.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 22/10/2022.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
    private let containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.1
        view.clipsToBounds = true
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let mapSnapshotView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let labelContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        return view
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        selectionStyle = .none
        backgroundColor = .clear
        addComponents()
        layoutComponents()
    }
    
    private func addComponents() {
        labelContainerView.addSubview(titleLabel)
        stackView.addArrangedSubviews([mapSnapshotView, labelContainerView])
        containerView.addSubview(stackView)
        addSubview(containerView)
    }
    
    private func layoutComponents() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: labelContainerView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: labelContainerView.bottomAnchor, constant: -8),
            mapSnapshotView.heightAnchor.constraint(equalToConstant: frame.width - 32)
        ])
    }
    
    func configure(with viewModel: TrackTableViewCellViewModel) {
        titleLabel.text = viewModel.name
        DispatchQueue.global().async {
            try? MapSnapshotGenerator.generateSnapshot(from: viewModel.coordinates) { [weak self] result in
                if case let .success(snapshot) = result {
                    DispatchQueue.main.async {
                        self?.mapSnapshotView.image = snapshot
                    }
                }
            }
        }
    }
}
