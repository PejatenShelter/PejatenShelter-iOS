//
//  UIViewController+AlertDisplaying.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 12/04/22.
//

import UIKit

protocol AlertDisplaying {
    func displayAlert(title: String?, message: String?, actions: [UIAlertAction], animated: Bool, completion: (() -> Void)?)
}

extension AlertDisplaying where Self: UIViewController {
    func displayAlert(title: String? = "",
                      message: String? = "",
                      actions: [UIAlertAction] = [],
                      animated: Bool = true,
                      completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alertController.addAction($0) }
        present(alertController, animated: animated, completion: completion)
    }
}

extension Sequence where Iterator.Element == UIAlertAction {
    static func ok(action: ((UIAlertAction) -> Void)? = nil) -> [UIAlertAction] {
        return [UIAlertAction(title: "OK", style: .default, handler: action)]
    }
    
    static func cancellable(title: String, destructive: Bool = false, action: ((UIAlertAction) -> Void)?) -> [UIAlertAction] {
        return [UIAlertAction(title: "Cancel", style: .cancel),
                UIAlertAction(title: title,
                              style: destructive ? .destructive : .default,
                              handler: action)]
    }
}
