//
//  UserAddressModel.swift
//  iOSResearch
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import EVReflection

final class UserAddress: EVObject {
	
	var city: String = ""
	var geo: LocationGeo = LocationGeo()
	var street: String = ""
	var suite: String = ""
	var zipcode: String = ""
	
}
