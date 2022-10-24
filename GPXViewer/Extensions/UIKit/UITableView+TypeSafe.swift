//
//  UITableView+TypeSafe.swift
//  GPXViewer
//
//  Created by Burak Akyalçın on 22/10/2022.
//

import UIKit

// Register a class with its name as an identifer
extension UITableView {
    public func register<T: UITableViewCell>(_ type: T.Type) {
        let className = String(describing: type)
        register(type, forCellReuseIdentifier: className)
    }

    public func register<T: UIView>(forHeaderFooter type: T.Type) {
        let className = String(describing: type)
        register(type, forHeaderFooterViewReuseIdentifier: className)
    }
}

// Dequeue a cell by a class name
extension UITableView {
    public func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as? T else { fatalError() }
        return cell
    }

    public func dequeueReusableHeaderFooterView<T: UIView>(_ type: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as? T else { fatalError() }
        return view
    }
}

