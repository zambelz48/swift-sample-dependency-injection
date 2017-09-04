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
	
	// MARK: Dependencies
	
	var mainFlowController: MainFlowController?
	var loginViewController: LoginViewController?
	
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
		
		guard let loginViewController = self.loginViewController else {
			return UIViewController()
		}
		
		loginViewController.onNavigationEvent = { [weak self] (event: LoginViewController.NavigationEvent) in
			
			switch event {
				
			case .homePage:
				self?.configureMainFlowController()
			
			}
		}
		
		return loginViewController
	}
	
	private func configureMainFlowController() {
		mainFlowController?.setInitialScreen(animated: true)
	}
	
}
