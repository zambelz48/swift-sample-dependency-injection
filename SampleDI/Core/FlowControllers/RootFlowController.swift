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
	
	// MARK: Dependencies
	
	var navigationController: UINavigationController
	var userModel: UserModel?
	var loginFlowController: LoginFlowController?
	var mainFlowController: MainFlowController?
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	// MARK: Public methods
	
	func configureInitialScreen() {
		
		guard userModel?.isAlreadyLoggedIn == true else {
			configureLoginFlowController()
			return
		}
		
		configureMainFlowController()
	}
	
	// MARK: Private methods
	
	private func configureLoginFlowController() {
		loginFlowController?.setInitialScreen()
	}
	
	private func configureMainFlowController() {
		mainFlowController?.setInitialScreen()
	}
	
}
