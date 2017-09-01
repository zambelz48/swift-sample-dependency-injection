//
//  NavigationBarStyle.swift
//  My Blue Bird
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

struct NavigationBarStyle {
	
	var tintColor: UIColor
	var barTintColor: UIColor?
	var defaultTitleBarTextColor: UIColor?
	var defaultFont: UIFont?
	var isTranslucent: Bool
	
	init(tintColor: UIColor = UIColor.white,
	     barTintColor: UIColor? = nil,
	     defaultTitleBarTextColor: UIColor? = nil,
	     defaultFont: UIFont? = nil,
	     isTranslucent: Bool = false) {
		
		self.tintColor = tintColor
		self.barTintColor = barTintColor
		self.defaultTitleBarTextColor = defaultTitleBarTextColor
		self.defaultFont = defaultFont
		self.isTranslucent = isTranslucent
	}
}
