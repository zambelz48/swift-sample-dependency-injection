//
//  UserService.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

final class UserService: UserServiceProtocol {
	
	private static let userEndPointUrl = "http://jsonplaceholder.typicode.com/users"
	private let networkManager: SessionManager
	
	init(networkManager: SessionManager = Alamofire.SessionManager.default) {
		self.networkManager = networkManager
	}
	
	func performLogin(username: String, password: String) -> Observable<User> {
		
		return Observable.create { [weak self] observer in
			
			guard password == "12345678" else {
				
				let error: NSError = NSError(
					domain: "SampleDI",
					code: -1,
					userInfo: [ NSLocalizedDescriptionKey : "Password invalid !" ]
				)
				
				observer.onError(error)
				
				return Disposables.create()
			}
			
			let parameter: [ String: String ] = [
				"username": username
			]
			
			self?.networkManager.request(UserService.userEndPointUrl,
			                             method: .get,
			                             parameters: parameter)
				.responseJSON { [weak self] response in
					
					switch response.result {
						
					case .success(let result):
						
						self?.parseJson(from: result) { (error: NSError?, data: Data?) in
							
							if let validError = error {
								observer.onError(validError)
								return
							}
							
							if let validData = data {
								
								let user = User(data: validData)
								
								observer.onNext(user)
								observer.onCompleted()
								
								return
							}
						}
						
					case .failure(let error):
						observer.onError(error)
						
					}
					
			}
			
			return Disposables.create()
		}
		
	}
	
	// MARK: Private methods
	
	private func parseJson(from response: Any,
	                       completion: @escaping (_ error: NSError?, _ data: Data?) -> Void) {
		
		guard let json: [[String: Any]] = response as? [[String: Any]] else {
			
			let error: NSError = NSError(
				domain: "SampleDI",
				code: -2,
				userInfo: [ NSLocalizedDescriptionKey : "Unknown error occurred !" ]
			)
			completion(error, nil)
			
			return
		}
		
		guard json.count > 0 else {
			
			let error: NSError = NSError(
				domain: "SampleDI",
				code: -2,
				userInfo: [ NSLocalizedDescriptionKey : "User does not exists !" ]
			)
			completion(error, nil)
			
			return
		}
		
		let jsonData = try? JSONSerialization.data(
			withJSONObject: json[0],
			options: .prettyPrinted
		)
		completion(nil, jsonData)
	}
	
}
