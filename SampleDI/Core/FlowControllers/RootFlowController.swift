//
//  RootFlowController.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

final class RootFlowController {
	
	// MARK: Private properties
	
	private var userModel: UserModel?
	private var loginFlowController: LoginFlowController?
	private var mainFlowController: MainFlowController?
	
	// MARK: Public properties
	
	var navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		
		self.navigationController = navigationController
		
		configureUserModel()
		configureInitialScreen()
	}
	
	// MARK: Private methods
	
	private func configureUserModel() {
		
		let userDefaults = UserDefaults.standard
		let userStorage = UserStorageProvider(userDefaults: userDefaults)
		userModel = UserModel(userStorageProvider: userStorage)
	}
	
	private func configureInitialScreen() {
		
		guard userModel?.isAlreadyLoggedIn == true else {
			configureLoginFlowController()
			return
		}
		
		configureMainFlowController()
	}
	
	private func configureLoginFlowController() {
		
		loginFlowController = LoginFlowController(navigationController: navigationController)
		loginFlowController?.setInitialScreen()
	}
	
	private func configureMainFlowController() {
		
		mainFlowController = MainFlowController(navigationController: navigationController)
		mainFlowController?.setInitialScreen()
	}
	
}
