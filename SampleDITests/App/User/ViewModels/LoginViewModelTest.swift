//
//  LoginViewModelTest.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import SampleDI

class LoginViewModelTest: XCTestCase {
	
	private var userServiceMock: UserServiceMock?
	private var userModelMock: UserModelMock?
	private var loginViewModel: LoginViewModel?
	private var disposeBag: DisposeBag?
	private var scheduler: TestScheduler?
	private var loginSuccessObserver: TestableObserver<Void>?
	private var loginFailedObserver: TestableObserver<Void>?
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
		
		disposeBag = DisposeBag()
		scheduler = TestScheduler(initialClock: 0)
		userServiceMock = UserServiceMock()
		userModelMock = UserModelMock()
		
		configureObjectsUnderTest()
		configureLoginResultObservables()
		
		scheduler?.start()
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		
		disposeBag = nil
		scheduler = nil
		userServiceMock = nil
		userModelMock = nil
		loginViewModel = nil
		
		super.tearDown()
	}
	
	// MARK: Not testable methods
	
	private func configureObjectsUnderTest() {
		
		guard let validUserServiceMock = userServiceMock,
			let validUserModelMock = userModelMock else {
				XCTFail("Something went wrong when obtaining 'LoginViewModel' dependencies")
				return
		}
		
		loginViewModel = LoginViewModel(
			userService: validUserServiceMock,
			userModel: validUserModelMock
		)
	}
	
	private func configureLoginResultObservables() {
		
		loginSuccessObserver = scheduler?.createObserver(Void.self)
		loginFailedObserver = scheduler?.createObserver(Void.self)
		
		guard let validDisposeBag = disposeBag else {
			XCTFail("Crap man, 'disposeBag' is nil")
			return
		}
		
		loginViewModel?.loginSuccessObservable
			.subscribe(onNext: { [weak self] in
				self?.loginSuccessObserver?.onNext()
			})
			.disposed(by: validDisposeBag)
		
		loginViewModel?.loginFailedObservable
			.subscribe(onNext: { [weak self] _ in
				self?.loginFailedObserver?.onNext()
			})
			.disposed(by: validDisposeBag)
	}
	
	// MARK: Testable methods
	
	// This test case is to check whether `next` event in `loginViewModel?.loginSuccessObservable` is triggered when user login info is valid
	func testUserLoginSuccess() {
		
		loginViewModel?.username.value = "tolong"
		loginViewModel?.password.value = "12345678"
		loginViewModel?.performLogin()
		
		guard let loginSuccessEvent = loginSuccessObserver?.events.count else {
			XCTFail("Something went wrong with 'loginSuccessObserver'")
			return
		}
		
		guard loginSuccessEvent == 1 else {
			XCTFail("Login is failed, but expected result is 'Success'")
			return
		}
		
		XCTAssertTrue(true)
	}
	
	// This test case is to check whether `next` event in `loginViewModel?.loginFailedObservable` is triggered when user login info is invalid
	func testUserLoginFailed() {
		
		loginViewModel?.username.value = "kambing"
		loginViewModel?.password.value = "gnibmak"
		loginViewModel?.performLogin()
		
		guard let loginFailedEvent = loginFailedObserver?.events.count else {
			XCTFail("Something went wrong with 'loginFailedObserver'")
			return
		}
		
		guard loginFailedEvent == 1 else {
			XCTFail("Login is success, but expected result is 'Fail'")
			return
		}
		
		XCTAssertTrue(true)
	}
	
}
