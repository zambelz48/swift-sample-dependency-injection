//
//  ContainerRegistrationFactory.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 9/6/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import Swinject

final class ContainerRegistrationFactory {

	private static let instance = ContainerRegistrationFactory()
	
	var container: Container?
	
	private init() { }
	
	static func set(container: Container) -> ContainerRegistrationFactory {
		
		instance.container = container
		
		return instance
	}
	
	func register() {
		
		guard let container = ContainerRegistrationFactory.instance.container else {
			return
		}
		
		CoreContainerRegistrationFactory
			.sharedInstance
			.register(using: container)
		
		AppContainerRegistrationFactory
			.sharedInstance
			.register(using: container)
	}
	
}
