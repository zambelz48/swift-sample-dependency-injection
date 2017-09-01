//
//  LoginViewModel.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

final class LoginViewModel {

	// MARK: Dependencies
	
	private var userService: UserServiceProtocol
	private var userModel: UserModelProtocol
	
	// MARK: Private properties
	
	private let minUsernameLength: Int = 5
	private let minPasswordLength: Int = 8
	private let loginSuccessSubject = PublishSubject<Void>()
	private let loginFailedSubject = PublishSubject<NSError>()
	private let disposeBag = DisposeBag()
	
	// MARK: Public properties
	
	var username = Variable<String>("")
	var password = Variable<String>("")
	var loginSuccessObservable: Observable<Void> {
		return loginSuccessSubject.asObservable()
	}
	var loginFailedObservable: Observable<NSError> {
		return loginFailedSubject.asObservable()
	}
	
	init(userService: UserServiceProtocol,
	     userModel: UserModelProtocol) {
		
		self.userService = userService
		self.userModel = userModel
		
		configureUserDataChangesObservable()
	}
	
	// MARK: Private methods
	
	private func configureUserDataChangesObservable() {
		
		userModel.userDataSuccessfullyChangedObservable
			.bind(to: loginSuccessSubject)
			.disposed(by: disposeBag)
		
		userModel.userDataFailChangedObservable
			.bind(to: loginFailedSubject)
			.disposed(by: disposeBag)
	}
	
	// MARK: Public methods
	
	func isUsernameValid() -> Observable<Bool> {
		
		return username.asObservable()
			.map { $0.count >= self.minUsernameLength }
	}
	
	func isPasswordValid() -> Observable<Bool> {
		
		return password.asObservable()
			.map { $0.count >= self.minPasswordLength }
	}
	
	func isUsernameAndPasswordValid() -> Observable<Bool> {
		
		return Observable
			.combineLatest(isUsernameValid(), isPasswordValid()) {
				$0 && $1
			}
			.distinctUntilChanged()
	}
	
	func performLogin() {
		
		userService.performLogin(
				username: username.value,
				password: password.value
			)
			.subscribe(
				onNext: { [weak self] user in
					self?.userModel.storeUserData(with: user)
				},
				onError: { [weak self] error in
					let nsError = error as NSError
					self?.loginFailedSubject.onNext(nsError)
				}
			)
			.disposed(by: disposeBag)
	}
	
	deinit {
		loginSuccessSubject.onCompleted()
		loginFailedSubject.onCompleted()
	}
	
}
