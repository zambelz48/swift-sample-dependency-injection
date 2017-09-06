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
		
		container.register(StorageProvider.self) { resolver in
			
			let userDefaults = UserDefaults.standard
			let userStorage = UserStorageProvider(userDefaults: userDefaults)
			
			return userStorage
		}
		
	}
	
	private func servicesRegistration(container: Container) {
		
		container.register(UserServiceProtocol.self) { _ in
			return UserService()
		}
	}
	
	private func modelsRegistration(container: Container) {
		
		container.register(UserModelProtocol?.self) { resolver in
			
			guard let userStorage = resolver.resolve(StorageProvider.self) else {
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
			.initCompleted { (resolver: Resolver, rootFlowController: RootFlowController?) in
				
				guard let userModel = resolver.resolve(UserModelProtocol?.self),
					let loginFlowController = resolver.resolve(LoginFlowController?.self),
					let mainFlowController = resolver.resolve(MainFlowController?.self) else {
						
						return
				}
				
				rootFlowController?.userModel = userModel
				rootFlowController?.loginFlowController = loginFlowController
				rootFlowController?.mainFlowController = mainFlowController
		}
		
		container
			.register(LoginFlowController?.self) { [weak self] resolver in
				
				guard let mainNavigationController = self?.navigationController(using: resolver) else {
					return nil
				}
				
				return LoginFlowController(navigationController: mainNavigationController)
			}
			.initCompleted { (resolver: Resolver, loginFlowController: LoginFlowController?) in
				
				guard let mainFlowController = resolver.resolve(MainFlowController?.self),
					let loginViewController = resolver.resolve(LoginViewController?.self) else {
						return
				}
				
				loginFlowController?.mainFlowController = mainFlowController
				loginFlowController?.loginViewController = loginViewController
		}
		
		container
			.register(MainFlowController?.self) { [weak self] resolver in
				
				guard let mainNavigationController = self?.navigationController(using: resolver) else {
					return nil
				}
				
				return MainFlowController(navigationController: mainNavigationController)
			}
			.initCompleted { (resolver: Resolver, mainFlowController: MainFlowController?) in
				
				guard let userModel = resolver.resolve(UserModelProtocol?.self),
					let loginFlowController = resolver.resolve(LoginFlowController?.self),
					let userDetailFlowController = resolver.resolve(UserDetailFlowController?.self),
					let mainViewController = resolver.resolve(MainViewController?.self) else {
						
						return
				}
				
				mainFlowController?.userModel = userModel
				mainFlowController?.loginFlowController = loginFlowController
				mainFlowController?.userDetailFlowController = userDetailFlowController
				mainFlowController?.mainViewController = mainViewController
		}
		
		container
			.register(UserDetailFlowController?.self) { [weak self] resolver in
				
				guard let mainNavigationController = self?.navigationController(using: resolver) else {
					return nil
				}
				
				return UserDetailFlowController(navigationController: mainNavigationController)
			}
			.initCompleted { (resolver: Resolver, userDetailFlowController: UserDetailFlowController?) in
				
				guard let userDetailViewController = resolver.resolve(UserDetailViewController?.self) else {
					return
				}
				
				userDetailFlowController?.userDetailViewController = userDetailViewController
		}
	}
	
}
