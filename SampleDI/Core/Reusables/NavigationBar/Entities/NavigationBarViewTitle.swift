//
//  NavigationBarViewTitle.swift
//  My Blue Bird
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

struct NavigationBarViewTitle: NavigationBarTitle {
	
	var view: UIView?
	
	init(_ view: UIView? = nil) {
		self.view = view
	}
	
}
