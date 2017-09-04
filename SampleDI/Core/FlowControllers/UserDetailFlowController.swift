//
//  UserDetailFlowController.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

final class UserDetailFlowController: FlowController {
	
	// MARK: `FlowController` properties
	
	enum Screen {
		case userDetailPage
	}
	
	var navigationController: UINavigationController
	
	// MARK: Dependencies
	
	var userDetailViewController: UserDetailViewController?
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	// MARK: `FlowController` methods
	
	func setInitialScreen(animated: Bool = false) {
		set(screen: .userDetailPage, animated: animated)
	}
	
	func viewControllerFor(screen: Screen) -> UIViewController {
		
		switch screen {
			
		case .userDetailPage:
			return createUserDetailViewController()
		
		}
	}
	
	// MARK: Private methods
	
	private func createUserDetailViewController() -> UIViewController {
		
		guard let userDetailViewController = self.userDetailViewController else {
			return UIViewController()
		}
		
		userDetailViewController.onNavigationEvent = { [weak self] (event: UserDetailViewController.NavigationEvent) in
			
			switch event {
				
			case .homePage:
				self?.pop(animated: true)
			
			}
		}
		
		return userDetailViewController
	}

}
