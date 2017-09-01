//
//  LoginFlowController.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

final class LoginFlowController: FlowController {
	
	// MARK: `FlowController` properties
	
	enum Screen {
		case loginPage
	}
	var navigationController: UINavigationController
	
	// MARK: Private properties
	
	private var mainFlowController: MainFlowController?
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	// MARK: `FlowController` methods
	
	func setInitialScreen(animated: Bool = false) {
		set(screen: .loginPage, animated: animated)
	}
	
	func viewControllerFor(screen: Screen) -> UIViewController {
		
		switch screen {
			
		case .loginPage:
			return createLoginViewController()
			
		}
	}
	
	// MARK: Private methods
	
	private func createLoginViewController() -> UIViewController {
		
		let userDefaults = UserDefaults.standard
		let userStorage = UserStorageProvider(userDefaults: userDefaults)
		let userModel = UserModel(userStorageProvider: userStorage)
		let userService = UserService()
		let loginViewModel = LoginViewModel(userService: userService, userModel: userModel)
		let loginViewController = LoginViewController(viewModel: loginViewModel)
		
		loginViewController.onNavigationEvent = { [weak self] (event: LoginViewController.NavigationEvent) in
			
			switch event {
				
			case .homePage:
				self?.configureMainFlowController()
			
			}
		}
		
		return loginViewController
	}
	
	private func configureMainFlowController() {
		
		mainFlowController = MainFlowController(navigationController: navigationController)
		mainFlowController?.setInitialScreen(animated: true)
	}
	
}
