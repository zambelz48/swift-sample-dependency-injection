//
//  StorageProvider.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

protocol StorageProvider {
	
	var dataChangesResultObservable: Observable<Bool> { get }
	
	func getData() -> Any?
	
	func save(data: Any?)
	
	func remove(with identifier: Any?)
	
}
