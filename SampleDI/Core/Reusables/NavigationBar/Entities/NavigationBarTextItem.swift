//
//  NavigationBarTextItem.swift
//  My Blue Bird
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

struct NavigationBarTextItem: NavigationBarItem {
	
	var title: String
	var color: UIColor?
	var enabled: Bool
	var font: UIFont?
	var onTapEvent: (() -> Void)?
	
	init(_ title: String = "",
	     color: UIColor? = nil,
	     enabled: Bool = true,
	     font: UIFont? = nil,
	     onTapEvent: (() -> Void)? = nil) {
		
		self.title = title
		self.color = color
		self.enabled = enabled
		self.font = font
		self.onTapEvent = onTapEvent
	}
	
}
