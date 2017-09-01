//
//  UserServiceMock.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

@testable import SampleDI

final class UserServiceMock: UserServiceProtocol {

	private var fakeUser: User {
		
		let fakeJsonData = [
			"id": 1,
			"name": "Tolong Kami Pak",
			"username": "tolong",
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
	
	func performLogin(username: String, password: String) -> Observable<User> {
		
		guard username == fakeUser.username, password == "12345678" else {
			let error: NSError = NSError(
				domain: "SampleDI_Tests",
				code: -2,
				userInfo: [ NSLocalizedDescriptionKey : "Unknown error occurred !" ]
			)
			return Observable.error(error)
		}
		
		return Observable.just(fakeUser)
	}
	
}
