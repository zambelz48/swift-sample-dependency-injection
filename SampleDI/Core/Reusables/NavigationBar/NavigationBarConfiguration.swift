//
//  NavigationBarConfiguration.swift
//  My Blue Bird
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

final class NavigationBarConfiguration {

	// MARK: Private properties
	
	private let navBarAppearance = UINavigationBar.appearance()
	
	// MARK: Public properties
	
	static let sharedInstance = NavigationBarConfiguration()
	var style: NavigationBarStyle?
	
	private init() { }
	
	// MARK: Public methods
	
	func configure(with style: NavigationBarStyle) {
		
		self.style = style
		
		guard let validStyle = self.style else {
			return
		}
		
		navBarAppearance.tintColor = validStyle.tintColor
		navBarAppearance.barTintColor = validStyle.barTintColor
		navBarAppearance.isTranslucent = validStyle.isTranslucent
		
		// TODO: Turns out that configuration below is needed, in order to clearing out default navigation bar color blur/transparency. is there any better workaround than this ? revisit this later.
		navBarAppearance.shadowImage = UIImage()
		navBarAppearance.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		
		// TODO: This is supposed to be make every item at status bar is set with lighten color(perhaps). but actually no luck here, figure out why this is happened, later.
		UIApplication.shared.statusBarStyle = .lightContent
	}
	
}
