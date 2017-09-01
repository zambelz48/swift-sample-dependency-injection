//
//  MainFlowController.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

final class MainFlowController: FlowController {

	// MARK: `FlowController` properties
	
	enum Screen {
		case homePage
	}
	var navigationController: UINavigationController
	
	// MARK: Private properties
	
	private var loginFlowController: LoginFlowController?
	private var userDetailFlowController: UserDetailFlowController?
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	// MARK: `FlowController` methods
	
	func setInitialScreen(animated: Bool = false) {
		set(screen: .homePage, animated: animated )
	}
	
	func viewControllerFor(screen: Screen) -> UIViewController {
		
		switch screen {
			
		case .homePage:
			return createMainViewController()
			
		}
	}
	
	// MARK: Private methods
	
	private func createMainViewController() -> UIViewController {
		
		let mainViewController = MainViewController()
		
		mainViewController.onNavigationEvent = { [weak self] (event: MainViewController.NavigationEvent) in
			
			switch event {
				
			case .logout:
				self?.configureLoginFlowController()
				
			case .userDetailPage:
				self?.configureUserDetailFlowController()
				
			}
			
		}
		
		return mainViewController
	}
	
	private func configureLoginFlowController() {
		
		let userDefaults = UserDefaults.standard
		let userStorage = UserStorageProvider(userDefaults: userDefaults)
		let userModel = UserModel(userStorageProvider: userStorage)
		
		userModel.clearUserData()
		
		loginFlowController = LoginFlowController(navigationController: navigationController)
		loginFlowController?.setInitialScreen(animated: true)
	}
	
	private func configureUserDetailFlowController() {
		
		userDetailFlowController = UserDetailFlowController(navigationController: navigationController)
		userDetailFlowController?.push(to: .userDetailPage, animated: true)
	}
	
}
