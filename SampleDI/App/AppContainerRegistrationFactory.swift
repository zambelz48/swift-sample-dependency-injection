//
//  AppContainerRegistrationFactory.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 9/6/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit
import Swinject

final class AppContainerRegistrationFactory {
	
	static let sharedInstance = AppContainerRegistrationFactory()
	
	private init() {}
	
	func register(using container: Container) {
		
		mainViewControllersRegistration(container: container)
		userViewControllersRegistration(container: container)
		userViewModelsRegistration(container: container)
	}
	
	private func mainViewControllersRegistration(container: Container) {
		
		container.register(MainViewController?.self) { _ in
			return MainViewController()
		}
	}
	
	private func userViewControllersRegistration(container: Container) {
		
		container.register(LoginViewController?.self) { resolver in
		
			guard let loginViewModel = resolver.resolve(LoginViewModel?.self),
				let validViewModel = loginViewModel else {
				return nil
			}
			
			return LoginViewController(viewModel: validViewModel)
		}
		
		container.register(UserDetailViewController?.self) { resolver in
			
			guard let viewModel = resolver.resolve(UserDetailViewModel?.self),
				let validViewModel = viewModel else {
					return nil
			}
			
			return UserDetailViewController(viewModel: validViewModel)
		}
	}
	
	private func userViewModelsRegistration(container: Container) {
		
		container.register(LoginViewModel?.self) { resolver in
		
			guard let userService = resolver.resolve(UserServiceProtocol.self),
				let userModel = resolver.resolve(UserModelProtocol?.self),
				let validUserModel = userModel else {
					return nil
			}
			
			return LoginViewModel(
				userService: userService,
				userModel: validUserModel
			)
		}
		
		container.register(UserDetailViewModel?.self) { resolver in
			
			guard let userModel = resolver.resolve(UserModelProtocol?.self),
				let validUserModel = userModel else {
					return nil
			}
			
			let viewModel = UserDetailViewModel(userModel: validUserModel)
			
			return viewModel
		}
	}
	
}
