//
//  AppDelegate.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 03/04/22.
//

import UIKit
import SwinjectStoryboard
import Firebase
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Swinject.setupDependencies()
        SwinjectStoryboard.setupDependencies()
        setupKeyboardManager()
        FirebaseApp.configure()
        return true
    }

    private func setupKeyboardManager() {
        let keyboardManager = IQKeyboardManager.shared
        
        keyboardManager.enable = true
        keyboardManager.shouldResignOnTouchOutside = true
        keyboardManager.enableAutoToolbar = false
    }
}

