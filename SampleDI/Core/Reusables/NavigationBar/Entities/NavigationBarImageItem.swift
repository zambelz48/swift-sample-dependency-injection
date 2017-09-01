//
//  NavigationBarImageItem.swift
//  My Blue Bird
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

struct NavigationBarImageItem: NavigationBarItem {

	var image: UIImage?
	var enabled: Bool
	var onTapEvent: (() -> Void)?
	
	init(_ image: UIImage? = nil,
	     enabled: Bool = true,
	     onTapEvent: (() -> Void)? = nil) {
		
		self.image = image
		self.enabled = enabled
		self.onTapEvent = onTapEvent
	}
	
}
