//
//  NavigationBarTextTitle.swift
//  My Blue Bird
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

struct NavigationBarTextTitle: NavigationBarTitle {
	
	var text: String
	var font: UIFont?
	var color: UIColor?
	
	init(_ text: String = "",
	     font: UIFont? = nil,
	     color: UIColor? = nil) {
		
		self.text = text
		self.font = font
		self.color = color
	}
	
}
