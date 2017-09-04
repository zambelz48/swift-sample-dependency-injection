//
//  Bootstrap.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit
import Swinject

final class Bootstrap {
	
	// MARK: Private properties
	
	private let navigationController = UINavigationController()
	private let window = UIWindow()
	private let container = Container()
	
	init() {
		
		configureProvidersContainer()
		configureServicesContainer()
		configureModelsContainer()
		configureViewModelsContainer()
		configureViewControllersContainer()
		configureFlowControllersContainer()
		configureRootNavigationControllerContainer()
		configureNavigationBarStyle()
	}
	
	// MARK: Public methods
	
	func run() {
		
		let rootNavigationController = container.resolve(
			UINavigationController.self,
			name: "rootNavigationController"
		)
		
		window.rootViewController = rootNavigationController
		window.makeKeyAndVisible()
	}
	
	// MARK: Private methods
	
	private func configureRootNavigationControllerContainer() {
		
		container.register(UINavigationController.self, name: "rootNavigationController") { resolver in
			
			let rootFlowController = resolver.resolve(RootFlowController?.self)
			rootFlowController??.configureInitialScreen()
			
			guard let navigationController = rootFlowController??.navigationController else {
				return UINavigationController()
			}
			
			return navigationController
		}
	}
	
	private func configureProvidersContainer() {
		
		container.register(UserStorageProvider.self) { resolver in
			
			let userDefaults = UserDefaults.standard
			let userStorage = UserStorageProvider(userDefaults: userDefaults)
			
			return userStorage
		}
		
	}
	
	private func configureServicesContainer() {
		
		container.register(UserService.self) { _ in
			return UserService()
		}
	}
	
	private func configureModelsContainer() {
		
		container.register(UserModel?.self) { resolver in
			
			guard let userStorage = resolver.resolve(UserStorageProvider.self) else {
				return nil
			}
			
			let userModel = UserModel(userStorageProvider: userStorage)
			
			return userModel
		}
	}
	
	private func configureViewModelsContainer() {
		
		container.register(LoginViewModel?.self) { resolver in
			
			guard let userService = resolver.resolve(UserService.self),
				let userModel = resolver.resolve(UserModel?.self),
				let validUserModel = userModel else {
					return nil
			}
			
			let viewModel = LoginViewModel(userService: userService, userModel: validUserModel)
			
			return viewModel
		}
		
		container.register(UserDetailViewModel?.self) { resolver in
			
			guard let userModel = resolver.resolve(UserModel?.self),
				let validUserModel = userModel else {
					return nil
			}
			
			let viewModel = UserDetailViewModel(userModel: validUserModel)
			
			return viewModel
		}
	}
	
	// MARK: Configure View Controller
	
	private func configureViewControllersContainer() {
		
		configureLoginViewControllerContainer()
		configureMainViewController()
		configureUserDetailViewController()
	}
	
	private func configureLoginViewControllerContainer() {
		
		container.register(LoginViewController?.self) { resolver in
			
			guard let viewModel = resolver.resolve(LoginViewModel?.self),
				let validViewModel = viewModel else {
					return nil
			}
			
			let viewController = LoginViewController(viewModel: validViewModel)
			
			return viewController
		}
	}
	
	private func configureMainViewController() {
		
		container.register(MainViewController?.self) { resolver in
			
			let viewController = MainViewController()
			
			return viewController
		}
	}
	
	private func configureUserDetailViewController() {
		
		container.register(UserDetailViewController?.self) { resolver in
			
			guard let viewModel = resolver.resolve(UserDetailViewModel?.self),
				let validViewModel = viewModel else {
					return nil
			}
			
			let viewController = UserDetailViewController(viewModel: validViewModel)
			
			return viewController
		}
	}
	
	// MARK: Configure Flow Controller
	
	private func configureFlowControllersContainer() {
		
		configureRootFlowControllerContainer()
		configureLoginFlowControllerContainer()
		configureMainFlowControllerContainer()
		configureUserDetailFlowControllerContainer()
	}
	
	private func configureRootFlowControllerContainer() {
		
		container
			.register(RootFlowController?.self) { [weak self] resolver in
				
				guard let mainNavigationController = self?.navigationController else {
					return nil
				}
				
				let flowController = RootFlowController(navigationController: mainNavigationController)
				
				return flowController
				
			}
			.initCompleted { (resolver: Resolver, flowController: RootFlowController?) in
				
				guard let userModel = resolver.resolve(UserModel?.self),
					let loginFlowController = resolver.resolve(LoginFlowController?.self),
					let mainFlowController = resolver.resolve(MainFlowController?.self) else {
						
						return
				}
				
				flowController?.userModel = userModel
				flowController?.loginFlowController = loginFlowController
				flowController?.mainFlowController = mainFlowController
		}
	}
	
	private func configureLoginFlowControllerContainer() {
		
		container
			.register(LoginFlowController?.self) { [weak self] _ in
				
				guard let mainNavigationController = self?.navigationController else {
					return nil
				}
				
				let flowController = LoginFlowController(navigationController: mainNavigationController)
				
				return flowController
			}
			.initCompleted { (resolver: Resolver, flowController: LoginFlowController?) in
				
				guard let mainFlowController = resolver.resolve(MainFlowController?.self),
					let loginViewController = resolver.resolve(LoginViewController?.self) else {
						return
				}
				
				flowController?.mainFlowController = mainFlowController
				flowController?.loginViewController = loginViewController
		}
	}
	
	private func configureMainFlowControllerContainer() {
		
		container
			.register(MainFlowController?.self) { [weak self] _ in
				
				guard let mainNavigationController = self?.navigationController else {
					return nil
				}
				
				let flowController = MainFlowController(navigationController: mainNavigationController)
				
				return flowController
			}
			.initCompleted { (resolver: Resolver, flowController: MainFlowController?) in
				
				guard let userModel = resolver.resolve(UserModel?.self),
					let loginFlowController = resolver.resolve(LoginFlowController?.self),
					let userDetailFlowController = resolver.resolve(UserDetailFlowController?.self),
					let mainViewController = resolver.resolve(MainViewController?.self) else {
						
						return
				}
				
				flowController?.userModel = userModel
				flowController?.loginFlowController = loginFlowController
				flowController?.userDetailFlowController = userDetailFlowController
				flowController?.mainViewController = mainViewController
		}
	}
	
	private func configureUserDetailFlowControllerContainer() {
		
		container
			.register(UserDetailFlowController?.self) { [weak self] _ in
				
				guard let mainNavigationController = self?.navigationController else {
					return nil
				}
				
				let flowController = UserDetailFlowController(navigationController: mainNavigationController)
				
				return flowController
			}
			.initCompleted { (resolver: Resolver, flowController: UserDetailFlowController?) in
				
				guard let userDetailViewController = resolver.resolve(UserDetailViewController?.self) else {
					return
				}
				
				flowController?.userDetailViewController = userDetailViewController
		}
	}
	
	private func configureNavigationBarStyle() {
		
		let style = NavigationBarStyle(
			tintColor: UIColor.white,
			barTintColor: UIColor.blue,
			defaultTitleBarTextColor: UIColor.white,
			defaultFont: UIFont.boldSystemFont(ofSize: 14),
			isTranslucent: false
		)
		
		NavigationBarConfiguration
			.sharedInstance
			.configure(with: style)
	}
	
}
