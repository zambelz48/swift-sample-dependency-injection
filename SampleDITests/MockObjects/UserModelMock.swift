//
//  UserModelMock.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

@testable import SampleDI

final class UserModelMock: UserModelProtocol {

	// MARK: Private properties
	private let disposeBag = DisposeBag()
	private let userStorageMock = UserStorageMock()
	private let userDataSuccessfullyChangedSubject = PublishSubject<Void>()
	private let userDataFailChangedSubject = PublishSubject<NSError>()
	
	// MARK: Public properties
	
	var userDataSuccessfullyChangedObservable: Observable<Void> {
		return userDataSuccessfullyChangedSubject.asObservable()
	}
	
	var userDataFailChangedObservable: Observable<NSError> {
		return userDataFailChangedSubject.asObservable()
	}
	
	var userData: User {
		
		guard let userData = userStorageMock.getData() as? NSDictionary else {
			return User()
		}
		
		return User(dictionary: userData)
	}
	
	var isAlreadyLoggedIn: Bool {
		return !userData.name.isEmpty
	}
	
	init() {
		configureDataChangesObservable()
	}
	
	// MARK: Private methods
	
	private func configureDataChangesObservable() {
		
		userStorageMock.dataChangesResultObservable
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
	
	// MARK: Public methods
	
	func storeUserData(with user: User) {
		userStorageMock.save(data: user)
	}
	
	func clearUserData() {
		userStorageMock.remove(with: "")
	}
	
}
