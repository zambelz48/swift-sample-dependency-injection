//
//  UserModel.swift
//  iOSResearch
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import EVReflection

final class User: EVObject {
	
	var id: Int = 0
	var name: String = ""
	var username: String = ""
	var email: String = ""
	var address: UserAddress = UserAddress()
	var phone: String = ""
	var website: String = ""
	var company: UserCompany = UserCompany()
	
}
