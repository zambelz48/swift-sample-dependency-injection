//
//  BaseFlowController.swift
//  iOSResearch
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

protocol FlowController {
	
	associatedtype Screen
	
	var navigationController: UINavigationController { get set }

	func viewControllerFor(screen: Screen) -> UIViewController
	
	func setInitialScreen(animated: Bool)
}

extension FlowController {
	
	private func setViewControllers(_ viewControllers: [UIViewController], animated: Bool = true) {
		navigationController.setViewControllers(viewControllers, animated: animated)
	}
	
	func set(screen: Screen, animated: Bool = false) {
		
		var viewControllers = [UIViewController]()
		let viewController = viewControllerFor(screen: screen)
		viewControllers.append(viewController)
		
		setViewControllers(viewControllers, animated: animated)
	}
	
	func sets(screens: [Screen], animated: Bool = false) {
		
		var viewControllers = [UIViewController]()
		
		screens.forEach { screen in
			let viewController = viewControllerFor(screen: screen)
			viewControllers.append(viewController)
		}
		
		setViewControllers(viewControllers, animated: animated)
	}
	
	func push(to screen: Screen, animated: Bool = false) {
		let viewController = viewControllerFor(screen: screen)
		navigationController.pushViewController(viewController, animated: animated)
	}
	
	func pop(animated: Bool = false) {
		navigationController.popViewController(animated: animated)
	}
	
	func pop(to screen: Screen, animated: Bool = false) {
		let viewController = viewControllerFor(screen: screen)
		navigationController.popToViewController(viewController, animated: animated)
	}
	
	func present(to screen: Screen, animated: Bool = false, completion: (() -> Void)? = nil) {
		let viewController = viewControllerFor(screen: screen)
		navigationController.present(viewController, animated: animated, completion: completion)
	}
	
	func dismiss(animated: Bool = false, completion: (() -> Void)? = nil) {
		navigationController.dismiss(animated: animated, completion: completion)
	}
	
}
