//
//  UITableView+Extension.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 02/07/2024.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cell: T.Type) {
        register(cell.self, forCellReuseIdentifier: cell.className)
    }

    func dequeueCell<T: UITableViewCell>(_ cell: T.Type, indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: cell.className, for: indexPath) as! T
    }
}
