//
//  UserDetailViewController.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import UIKit

final class UserDetailViewController: UIViewController {

	// MARK: Dependencies
	
	private var viewModel: UserDetailViewModel?
	
	// MARK: public properties
	
	enum NavigationEvent {
		case homePage
	}
	var onNavigationEvent: ((NavigationEvent) -> Void)?
	
	init(viewModel: UserDetailViewModel) {
		super.init(nibName: nil, bundle: nil)
		self.viewModel = viewModel
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupNavigationBar()
    }

}

extension UserDetailViewController: NavigationBarCreator {
	
	func createTitleBar() -> NavigationBarTitle? {
		return NavigationBarTextTitle("User Detail")
	}
	
	func createLeftBarButtonItem() -> NavigationBarItem? {
		
		return NavigationBarTextItem("< Back") { [weak self] in
			self?.onNavigationEvent?(.homePage)
		}
	}
	
}
