//
//  LoginViewController.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
	
	// MARK Dependencies
	
	private var viewModel: LoginViewModel?
	
	// MARK: IBOutlet declarations
	
	@IBOutlet weak private var usernameField: UITextField!
	@IBOutlet weak private var passwordField: UITextField!
	@IBOutlet weak private var loginButton: UIButton!
	
	// MARK: private properties
	
	private let disposeBag = DisposeBag()
	
	// MARK: public properties
	
	enum NavigationEvent {
		case homePage
	}
	
	var onNavigationEvent: ((NavigationEvent) -> Void)?
	
	init(viewModel: LoginViewModel) {
		super.init(nibName: nil, bundle: nil)
		self.viewModel = viewModel
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupNavigationBar()
		
		configureTextField()
		configureValidationRule()
		configureLoginState()
	}
	
	// MARK: private methods
	
	private func configureTextField() {
		
		usernameField.rx.text
			.subscribe(onNext: { [weak self] text in
				
				guard let username = text else {
					return
				}
				
				self?.viewModel?.username.value = username
			})
			.disposed(by: disposeBag)
		
		passwordField.rx.text
			.subscribe(onNext: { [weak self] text in
				
				guard let password = text else {
					return
				}
				
				self?.viewModel?.password.value = password
			})
			.disposed(by: disposeBag)
	}
	
	private func configureValidationRule() {
		
		viewModel?.isUsernameValid()
			.observeOn(MainScheduler.instance)
			.bind(to: passwordField.rx.isEnabled)
			.disposed(by: disposeBag)
		
		viewModel?.isUsernameAndPasswordValid()
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { [weak self] isValid in
				self?.loginButton.isUserInteractionEnabled = isValid
				self?.loginButton.alpha = isValid ? 1.0 : 0.5
			})
			.disposed(by: disposeBag)
	}
	
	private func configureLoginState() {
		
		viewModel?.loginSuccessObservable
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { [weak self] in
				self?.onNavigationEvent?(.homePage)
			})
			.disposed(by: disposeBag)
		
		viewModel?.loginFailedObservable
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { [weak self] error in
				
				let actionClose = UIAlertAction(
					title: "Close",
					style: UIAlertActionStyle.destructive
				)
				
				self?.showAlert(
					title: "Error",
					message: error.localizedDescription,
					action: actionClose
				)
			})
			.disposed(by: disposeBag)
	}
	
	// MARK: @IBAction implementations
	
	@IBAction private func loginButton_Clicked(_ sender: Any) {
		viewModel?.performLogin()
	}
	
}

extension LoginViewController: NavigationBarCreator {
	
	func createTitleBar() -> NavigationBarTitle? {
		return NavigationBarTextTitle("Login")
	}
	
}
