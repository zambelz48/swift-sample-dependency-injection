//
//  NavigationBarItem.swift
//  My Blue Bird
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

protocol NavigationBarItem {
	
	var enabled: Bool { get set }
	var onTapEvent: (() -> Void)? { get set }
	
}
