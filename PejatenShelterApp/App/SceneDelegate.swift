//
//  SceneDelegate.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 03/04/22.
//

import UIKit
import SwinjectStoryboard

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let defaultsStore = SwinjectStoryboard.defaultContainer
        .resolve(DefaultsStore.self)!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let rootStoryboard = getRootStoryboard()
        window.rootViewController = rootStoryboard.instantiateInitialViewController()
        
        self.window = window
        window.makeKeyAndVisible()
    }
    
    private func skipAuth() -> Bool {
        return defaultsStore.isUserLoggedIn()
    }
    
    private func getRootStoryboard() -> UIStoryboard {
        return .init(name: skipAuth() ? "Main" : "Auth", bundle: nil)
    }

}
