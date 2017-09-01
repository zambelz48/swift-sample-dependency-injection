//
//  UserModel.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

final class UserModel: UserModelProtocol {

	// MARK: Dependencies
	
	private var userStorageProvider: StorageProvider
	
	// MARK: Private properties
	
	private let disposeBag = DisposeBag()
	private let userDataSuccessfullyChangedSubject = PublishSubject<Void>()
	private let userDataFailChangedSubject = PublishSubject<NSError>()
	
	// MARK: Public properties
	
	var userData: User {
		
		guard let userData = userStorageProvider.getData() as? NSDictionary else {
			return User()
		}
		
		return User(dictionary: userData)
	}
	var isAlreadyLoggedIn: Bool {
		return !userData.username.isEmpty
	}
	var userDataSuccessfullyChangedObservable: Observable<Void> {
		return userDataSuccessfullyChangedSubject.asObservable()
	}
	var userDataFailChangedObservable: Observable<NSError> {
		return userDataFailChangedSubject.asObservable()
	}
	
	init(userStorageProvider: StorageProvider) {
		
		self.userStorageProvider = userStorageProvider
		
		configureUserDataChangesObservable()
	}
	
	// MARK: Public methods
	
	func storeUserData(with user: User) {
		userStorageProvider.save(data: user)
	}
	
	func clearUserData() {
		userStorageProvider.remove(with: "")
	}
	
	// MARK: Private methods
	
	private func configureUserDataChangesObservable() {
		
		userStorageProvider.dataChangesResultObservable
			.subscribe(onNext: { [weak self] isSuccess in
				
				guard !isSuccess else {
					self?.userDataSuccessfullyChangedSubject.onNext()
					return
				}
				
				let error: NSError = NSError(
					domain: "SampleDI",
					code: -4,
					userInfo: [ NSLocalizedDescriptionKey : "Failed to change user data in storage !" ]
				)
				self?.userDataFailChangedSubject.onNext(error)
			})
			.disposed(by: disposeBag)
	}
	
	deinit {
		userDataSuccessfullyChangedSubject.onCompleted()
		userDataFailChangedSubject.onCompleted()
	}
	
}
