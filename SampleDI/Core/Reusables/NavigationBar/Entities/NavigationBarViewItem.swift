//
//  NavigationBarViewItem.swift
//  My Blue Bird
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

struct NavigationBarViewItem: NavigationBarItem {
	
	var view: UIView?
	var enabled: Bool
	var onTapEvent: (() -> Void)?
	
	init(_ view: UIView? = nil,
	     enabled: Bool = true,
	     onTapEvent: (() -> Void)? = nil) {
		
		self.view = view
		self.enabled = enabled
		self.onTapEvent = onTapEvent
	}
	
}
