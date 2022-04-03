//
//  LoginViewController.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 03/04/22.
//

import UIKit
import IQKeyboardManagerSwift
import SwinjectStoryboard

final class LoginViewController: UIViewController, AlertDisplaying {
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel = SwinjectStoryboard.defaultContainer
        .resolve(LoginViewModel.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
        usernameTextField.text = "admin"
        passwordTextField.text = "qwertyuiop"
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigation()
    }
    
    private func setupNavigation() {
        navigationItem.title = "Login"
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction private func didTapLogin() {
        activityIndicator.startAnimating()
        Task.init {
            do {
                try await viewModel.login(username: usernameTextField.text,
                                          password: passwordTextField.text) {
                    DispatchQueue.main.async { [weak self] in
                        self?.activityIndicator.stopAnimating()
                        self?.pushLoginView()
                    }
                }
            } catch {
                activityIndicator.stopAnimating()
                showAlert(with: error)
            }
        }
    }
    
    private func showAlert(with error: Error) {
        let authError = error as? DescribedError
        displayAlert(title: "Login Gagal",
                     message: authError?.description,
                     actions: .ok())
    }
    
    private func pushLoginView() {
        do {
            try replaceRootViewController(to: R.storyboard.main())
        } catch {
            showAlert(with: error)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
            didTapLogin()
        }
        return true
    }
}
