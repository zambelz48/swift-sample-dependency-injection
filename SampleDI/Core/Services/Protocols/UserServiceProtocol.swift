//
//  UserServiceProtocol.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

protocol UserServiceProtocol {
	
	func performLogin(username: String, password: String) -> Observable<User>
	
}
