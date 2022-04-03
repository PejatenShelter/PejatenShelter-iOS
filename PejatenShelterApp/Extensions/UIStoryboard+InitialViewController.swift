//
//  UIStoryboard+InitialViewController.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 02/05/22.
//

import UIKit

extension UIStoryboard {
    func initialViewController() throws -> UIViewController {
        guard let viewController = instantiateInitialViewController()
        else { throw NavigationError.viewControllerNotFound }
        
        return viewController
    }
}
