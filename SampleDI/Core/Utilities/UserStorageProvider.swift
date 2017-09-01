//
//  UserStorageProvider.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

final class UserStorageProvider: StorageProvider {
	
	// MARK: Dependencies
	
	private let userDefaults: UserDefaults
	
	// MARK: Private properties
	
	private let userKey = "userData"
	private let dataChangesResultSubject = PublishSubject<Bool>()
	
	// MARK: Publis properties
	
	var dataChangesResultObservable: Observable<Bool> {
		return dataChangesResultSubject.asObservable()
	}
	
	init(userDefaults: UserDefaults) {
		self.userDefaults = userDefaults
	}
	
	// MARK: Public properties
	
	func getData() -> Any? {
		
		guard let userData = userDefaults.dictionary(forKey: userKey) as NSDictionary? else {
			return nil
		}
		
		return userData
	}
	
	func save(data: Any?) {
		
		guard let userData = data as? User else {
			dataChangesResultSubject.onNext(false)
			return
		}
		
		userDefaults.set(userData.toDictionary(), forKey: userKey)
		dataChangesResultSubject.onNext(userDefaults.synchronize())
	}
	
	func remove(with identifier: Any?) {
		
		userDefaults.removeObject(forKey: userKey)
		dataChangesResultSubject.onNext(userDefaults.synchronize())
	}
	
}
