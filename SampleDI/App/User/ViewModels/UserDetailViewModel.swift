//
//  UserDetailViewModel.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation

final class UserDetailViewModel {

	// MARK: Dependencies
	
	private var userModel: UserModelProtocol
	
	init(userModel: UserModelProtocol) {
		self.userModel = userModel
	}
	
}
