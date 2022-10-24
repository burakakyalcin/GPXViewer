//
//  UIStackView+Utils.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 22/10/2022.
//

import UIKit

extension UIStackView {
    public convenience init(arrangedSubviews: [UIView], alignment: UIStackView.Alignment = .fill) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.alignment = alignment
    }

    public func removeAllSubviews() {
        let removedSubviews: [UIView] = arrangedSubviews.map {
            self.removeArrangedSubview($0)
            return $0
        }

        removedSubviews.forEach({ $0.removeFromSuperview() })
    }

    public func addArrangedSubviews(_ arrangedSubviews: [UIView]) {
        arrangedSubviews.forEach { addArrangedSubview($0) }
    }

    public func addBackgroundView(with color: UIColor?) {
        let view = UIView()
        if let color = color {
            view.backgroundColor = color
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(view, at: 0)

        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
