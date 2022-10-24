//
//  TrackInfoTableViewCell.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 23/10/2022.
//

import UIKit

class TrackInfoTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        stackView.addArrangedSubviews([titleLabel, UIView(), infoLabel])
        addSubview(stackView)
    }
    
    private func layoutComponents() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with viewModel: TrackInfoTableViewCellViewModel) {
        titleLabel.text = viewModel.name
        infoLabel.text = viewModel.description
    }
    
}
