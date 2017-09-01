//
//  MainViewController.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

	// MARK: public properties
	
	enum NavigationEvent {
		case logout
		case userDetailPage
	}
	var onNavigationEvent: ((NavigationEvent) -> Void)?
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupNavigationBar()
    }

}

extension MainViewController: NavigationBarCreator {
	
	func createTitleBar() -> NavigationBarTitle? {
		
		return NavigationBarTextTitle("Home")
	}
	
	func createLeftBarButtonItem() -> NavigationBarItem? {
		
		return NavigationBarTextItem("Logout") { [weak self] in
			self?.onNavigationEvent?(.logout)
		}
	}
	
	func createRightBarButtonItem() -> NavigationBarItem? {
		
		return NavigationBarTextItem("User profile") { [weak self] in
			self?.onNavigationEvent?(.userDetailPage)
		}
	}
	
}
