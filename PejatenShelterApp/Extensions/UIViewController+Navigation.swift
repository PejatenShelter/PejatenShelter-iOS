//
//  UIViewController+Navigation.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 02/05/22.
//

import UIKit

extension UIViewController {
    func pushInitialViewController(
        from storyboard: UIStoryboard,
        animated: Bool = true
    ) throws {
        let viewController = try storyboard.initialViewController()
        
        guard let navigationController = navigationController
        else { throw NavigationError.navigationControllerNotFound }
        
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func replaceRootViewController(to viewController: UIViewController) throws {
        guard let window = view.window
        else { throw NavigationError.windowNotFound }
        
        window.rootViewController = viewController
    }
    
    func replaceRootViewController(to storyboard: UIStoryboard) throws {
        guard let window = view.window
        else { throw NavigationError.windowNotFound }
        
        window.rootViewController = try storyboard.initialViewController()
        
        UIView.transition(
            with: window,
            duration: 1,
            options: .transitionCurlUp,
            animations: nil
        )
    }
}
