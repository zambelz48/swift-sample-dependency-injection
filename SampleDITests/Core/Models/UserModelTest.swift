//
//  UserModelTest.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import XCTest

@testable import SampleDI

class UserModelTest: XCTestCase {
	
	private var fakeUser: User {
		
		let fakeJsonData = [
			"id": 1,
			"name": "Leanne Graham",
			"username": "Bret",
			"email": "Sincere@april.biz",
			"address": [
				"street": "Kulas Light",
				"suite": "Apt. 556",
				"city": "Gwenborough",
				"zipcode": "92998-3874",
				"geo": [
					"lat": "-37.3159",
					"lng": "81.1496"
				]
			],
			"phone": "1-770-736-8031 x56442",
			"website": "hildegard.org",
			"company": [
				"name": "Romaguera-Crona",
				"catchPhrase": "Multi-layered client-server neural-net",
				"bs": "harness real-time e-markets"
			]
		] as NSDictionary
		
		return User(dictionary: fakeJsonData)
	}
	
	private var userStorageMock: UserStorageMock?
	private var userModel: UserModel?
	
    override func setUp() {
        super.setUp()
		
		userStorageMock = UserStorageMock()
		
		configureObjectsUnderTest()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		
		userStorageMock = nil
		userModel = nil
		
        super.tearDown()
    }
	
	// MARK: Not testable methods
	
	private func configureObjectsUnderTest() {
		
		guard let validUserStorageMock = userStorageMock else {
			XCTFail("Something went wrong when obtaining 'UserModel' dependencies")
			return
		}
		
		userModel = UserModel(userStorageProvider: validUserStorageMock)
	}
	
	// MARK: Testable methods
	
	// This test case is to check whether `userModel?.storeUserData(with:)` method is working as expected or not. by comparing between `userModel?.userData` values with `fakeUser` values should be equal.
    func testSaveUser() {
		
		userModel?.storeUserData(with: fakeUser)
		
		guard let userData = userModel?.userData else {
			XCTFail("'userModel?.userData' is nil")
			return
		}
		
		XCTAssertEqual(userData, fakeUser)
    }
	
	// This test case is to check whether `userModel?.clearUserData()` method is working as expected or not. by comparing between `userModel?.userData` values with `fakeUser` values should be not equal.
	func testRemoveUser() {
		
		userModel?.clearUserData()
		
		guard let userData = userModel?.userData else {
			XCTFail("'userModel?.userData' is nil")
			return
		}
		
		XCTAssertNotEqual(userData, fakeUser)
	}
    
}
