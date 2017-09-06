//
//  Bootstrap.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

final class Bootstrap {
	
	// MARK: Private properties
	
	private var window: UIWindow
	private var navigationController: UINavigationController
	private var rootFlowController: RootFlowController?
	
	init() {
		
		window = UIWindow()
		navigationController = UINavigationController()
	}
	
	// MARK: Public methods
	
	func run() {
		
		configureNavigationBarStyle()
		
		window.rootViewController = rootViewController()
		window.makeKeyAndVisible()
	}
	
	// MARK: Private methods
	
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
	
	private func rootViewController() -> UIViewController {
		
		rootFlowController = RootFlowController(navigationController: navigationController)
		
		guard let rootViewController = rootFlowController?.navigationController else {
			return UIViewController()
		}
		
		return rootViewController
	}
	
}
