//
//  UserStorageMock.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

@testable import SampleDI

class UserStorageMock: StorageProvider {
	
	private let dataChangeResultSubject = PublishSubject<Bool>()
	
	private var userData: NSDictionary?
	
	var dataChangesResultObservable: Observable<Bool> {
		return dataChangeResultSubject.asObservable()
	}
	
	init() {
		userData = NSDictionary()
	}
	
	func getData() -> Any? {
		return userData
	}
	
	func save(data: Any?) {
		
		guard let user = data as? User else {
			dataChangeResultSubject.onNext(false)
			return
		}
		
		userData = user.toDictionary()
		dataChangeResultSubject.onNext(true)
	}
	
	func remove(with identifier: Any?) {
		userData = nil
		dataChangeResultSubject.onNext(true)
	}
	
}
