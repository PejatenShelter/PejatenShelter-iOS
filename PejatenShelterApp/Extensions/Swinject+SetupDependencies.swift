//
//  Swinject+SetupDependencies.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 03/04/22.
//

import Foundation
import Swinject
import SwinjectStoryboard
import UIKit

final class Swinject {
    class func setupDependencies() {
        let container = SwinjectStoryboard.defaultContainer
        
        container.register(AuthProviding.self) { _ in FirebaseAuthAdapter() }
        container.register(DefaultsStore.self) { _ in DefaultsStoreImpl() }
        container.register(ApiService.self) { _ in AirtableAdapter() }
        container.register(AnimalService.self) { r in
            let apiService = r.resolve(ApiService.self)!
            return AnimalServiceImpl(apiService: apiService)
        }
        container.register(AdopterService.self) { r in
            let apiService = r.resolve(ApiService.self)!
            return AdopterServiceImpl(apiService: apiService)
        }
        container.register(ImageUploadService.self) { _ in
            FirebaseStorageAdapter()
        }
    }
}

extension SwinjectStoryboard {
    class func setupDependencies() {
        registerViewModels()
        registerStoryboards()
    }
    
    class func registerViewModels() {
        defaultContainer.register(LoginViewModel.self) { r in
            let authProvider = r.resolve(AuthProviding.self)!
            let defaultsStore = r.resolve(DefaultsStore.self)!
            return LoginViewModel(authProvider: authProvider,
                                  defaultsStore: defaultsStore)
        }
        defaultContainer.register(AnimalListViewModel.self) { r in
            let animalService = r.resolve(AnimalService.self)!
            return AnimalListViewModel(animalService: animalService)
        }
        defaultContainer.register(AdopterListViewModel.self) { r in
            let adopterService = r.resolve(AdopterService.self)!
            return AdopterListViewModel(adopterService: adopterService)
        }
        defaultContainer.register(AnimalDetailsViewModel.self) { r in
            let animalService = r.resolve(AnimalService.self)!
            let imageUploadService = r.resolve(ImageUploadService.self)!
            return AnimalDetailsViewModel(
                animalService: animalService,
                imageUploadService: imageUploadService
            )
        }
        defaultContainer.register(CreateAnimalViewModel.self) { r in
            let animalService = r.resolve(AnimalService.self)!
            let imageUploadService = r.resolve(ImageUploadService.self)!
            return CreateAnimalViewModel(
                animalService: animalService,
                imageUploadService: imageUploadService
            )
        }
        defaultContainer.register(AdopterDetailsViewModel.self) { r in
            let adopterService = r.resolve(AdopterService.self)!
            return AdopterDetailsViewModel(adopterService: adopterService)
        }
    }
    
    class func registerStoryboards() {
        defaultContainer
            .storyboardInitCompleted(LoginViewController.self) { _, _ in }
        defaultContainer
            .storyboardInitCompleted(AnimalListViewController.self) { _, _ in }
        defaultContainer
            .storyboardInitCompleted(AdopterListViewController.self) { _, _ in }
        defaultContainer.storyboardInitCompleted(UINavigationController.self) { _, _ in }
        defaultContainer.storyboardInitCompleted(UITabBarController.self) { _, _ in }
    }
}
