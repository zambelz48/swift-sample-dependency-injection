//
//  UserModelProtocol.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

protocol UserModelProtocol {
	
	var userDataSuccessfullyChangedObservable: Observable<Void> { get }
	
	var userDataFailChangedObservable: Observable<NSError> { get }
	
	var userData: User { get }

	var isAlreadyLoggedIn: Bool { get }
	
	func storeUserData(with user: User)
	
	func clearUserData()
	
}
