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
	
	private let window = UIWindow()
	private let container = Container()
	
	init() {
		
		configureContainers()
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
	
	private func configureContainers() {
		
		container.register(UINavigationController.self, name: "mainNavigationController") { _ in
			return UINavigationController()
		}
		
		container.register(UINavigationController.self, name: "rootNavigationController") { resolver in
			
			let rootFlowController = resolver.resolve(RootFlowController?.self)
			rootFlowController??.configureInitialScreen()
			
			guard let navigationController = rootFlowController??.navigationController else {
				return UINavigationController()
			}
			
			return navigationController
		}
		
		ContainerRegistrationFactory
			.set(container: container)
			.register()
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
