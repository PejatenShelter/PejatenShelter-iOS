//
//  UIViewController+SetupShadows.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 23/04/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setupShadows() {
        setupTabBarShadows()
        setupNavigationBarShadows()
    }
    
    private func setupTabBarShadows() {
        guard let tabBar = tabBarController?.tabBar else { return }
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        tabBar.layer.masksToBounds = false
    }
    
    private func setupNavigationBarShadows() {
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        navBar.layer.shadowRadius = 2
        navBar.layer.shadowColor = UIColor.black.cgColor
        navBar.layer.shadowOpacity = 0.3
        navBar.layer.masksToBounds = false
    }
}
