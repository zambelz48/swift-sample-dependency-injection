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
	
	// MARK: Dependencies
	
	var userModel: UserModel?
	var loginFlowController: LoginFlowController?
	var userDetailFlowController: UserDetailFlowController?
	var mainViewController: MainViewController?
	
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
		
		guard let mainViewController = self.mainViewController else {
			return UIViewController()
		}
		
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
		
		userModel?.clearUserData()
		
		loginFlowController?.setInitialScreen(animated: true)
	}
	
	private func configureUserDetailFlowController() {
		userDetailFlowController?.push(to: .userDetailPage, animated: true)
	}
	
}
