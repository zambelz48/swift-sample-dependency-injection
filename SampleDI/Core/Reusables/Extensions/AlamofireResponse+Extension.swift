//
//  AlamofireResponse+Extension.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import Alamofire

extension Alamofire.Result where Value: Any {

	/// Get specific json value from Alamofire.Result
	func getJSONValue<T>(from key: String = "") -> T? {
		
		let jsonResponse = value as? [String: Any]
		
		guard let response = jsonResponse?[key] else {
			return nil
		}
		
		return response as? T
	}
	
}
