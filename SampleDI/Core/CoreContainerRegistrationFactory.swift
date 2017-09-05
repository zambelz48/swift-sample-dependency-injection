//
//  CoreContainerRegistrationFactory.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 9/6/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit
import Swinject

final class CoreContainerRegistrationFactory {

	static let sharedInstance = CoreContainerRegistrationFactory()
	
	private init() {}
	
	func register(using container: Container) {
	
		utilitiesRegistration(container: container)
		servicesRegistration(container: container)
		modelsRegistration(container: container)
		flowControllersRegistration(container: container)
	}
	
	private func navigationController(using resolver: Resolver) -> UINavigationController {
	
		guard let navigationController = resolver.resolve(UINavigationController.self, name: "mainNavigationController") else {
			return UINavigationController()
		}
		
		return navigationController
	}
	
	private func utilitiesRegistration(container: Container) {
		
		container.register(UserStorageProvider.self) { resolver in
			
			let userDefaults = UserDefaults.standard
			let userStorage = UserStorageProvider(userDefaults: userDefaults)
			
			return userStorage
		}
		
	}
	
	private func servicesRegistration(container: Container) {
		
		container.register(UserService.self) { _ in
			return UserService()
		}
	}
	
	private func modelsRegistration(container: Container) {
		
		container.register(UserModel?.self) { resolver in
			
			guard let userStorage = resolver.resolve(UserStorageProvider.self) else {
				return nil
			}
			
			return UserModel(userStorageProvider: userStorage)
		}
	}
	
	private func flowControllersRegistration(container: Container) {
		
		container
			.register(RootFlowController?.self) { [weak self] resolver in
				
				guard let mainNavigationController = self?.navigationController(using: resolver) else {
					return nil
				}
				
				return RootFlowController(navigationController: mainNavigationController)
				
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
		
		container
			.register(LoginFlowController?.self) { [weak self] resolver in
				
				guard let mainNavigationController = self?.navigationController(using: resolver) else {
					return nil
				}
				
				return LoginFlowController(navigationController: mainNavigationController)
			}
			.initCompleted { (resolver: Resolver, flowController: LoginFlowController?) in
				
				guard let mainFlowController = resolver.resolve(MainFlowController?.self),
					let loginViewController = resolver.resolve(LoginViewController?.self) else {
						return
				}
				
				flowController?.mainFlowController = mainFlowController
				flowController?.loginViewController = loginViewController
		}
		
		container
			.register(MainFlowController?.self) { [weak self] resolver in
				
				guard let mainNavigationController = self?.navigationController(using: resolver) else {
					return nil
				}
				
				return MainFlowController(navigationController: mainNavigationController)
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
		
		container
			.register(UserDetailFlowController?.self) { [weak self] resolver in
				
				guard let mainNavigationController = self?.navigationController(using: resolver) else {
					return nil
				}
				
				return UserDetailFlowController(navigationController: mainNavigationController)
			}
			.initCompleted { (resolver: Resolver, flowController: UserDetailFlowController?) in
				
				guard let userDetailViewController = resolver.resolve(UserDetailViewController?.self) else {
					return
				}
				
				flowController?.userDetailViewController = userDetailViewController
		}
	}
	
}
