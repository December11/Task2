//
//  UITableView+Reusable.swift
//  Task2
//
//  Created by Alla Shkolnik on 28.06.2022.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard
            let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T
        else { return T() }
        
        return cell
    }
    
}
