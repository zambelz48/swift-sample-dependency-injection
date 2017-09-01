//
//  NavigationBar.swift
//  My Blue Bird
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

protocol NavigationBarCreator: class {
	
	func createTitleBar() -> NavigationBarTitle?
	
	func createLeftBarButtonItem() -> NavigationBarItem?
	
	func createRightBarButtonItem() -> NavigationBarItem?
	
}

extension NavigationBarCreator where Self: UIViewController {
	
	// MARK: Navigation bar default configuration value
	
	private var style: NavigationBarStyle {
		
		guard let style = NavigationBarConfiguration.sharedInstance.style else {
			return NavigationBarStyle()
		}
		
		return style
	}
	
	// MARK: Default `NavigationBarCreator` implementations
	
	func createTitleBar() -> NavigationBarTitle? {
		return nil
	}
	
	func createLeftBarButtonItem() -> NavigationBarItem? {
		return nil
	}
	
	func createRightBarButtonItem() -> NavigationBarItem? {
		return nil
	}
	
	// MARK: Public methods
	
	func setupNavigationBar() {
		
		configureTitleBar()
		configureLeftBarButtonItem()
		configureRightBarButtonItem()
	}
	
	// MARK: Private methods
	
	private func configureTitleBar() {
		
		if let titleText = createTitleBar() as? NavigationBarTextTitle {
			configureTitleBarTextAttributes(titleText)
			return
		}
		
		if let titleView = createTitleBar() as? NavigationBarViewTitle {
			navigationItem.titleView = titleView.view
			return
		}
	}
	
	private func configureLeftBarButtonItem() {
		
		guard let item = createLeftBarButtonItem(),
			let barButtonItem = createBarButtonItem(item) else {
				return
		}
		
		navigationItem.leftBarButtonItem = barButtonItem
	}
	
	private func configureRightBarButtonItem() {
		
		guard let item = createRightBarButtonItem(),
			let barButtonItem = createBarButtonItem(item) else {
				return
		}
		
		navigationItem.rightBarButtonItem = barButtonItem
	}
	
	private func createBarButtonItem(_ item: NavigationBarItem) -> UIBarButtonItem? {
		
		if let itemText = item as? NavigationBarTextItem {
			
			return configureBarItemText(itemText)
			
		} else if let itemView = item as? NavigationBarViewItem {
			
			return configureBarItemView(itemView)
			
		} else if let itemImage = item as? NavigationBarImageItem {
			
			return configureBarItemImage(itemImage)
			
		}
		
		return nil
	}
	
	private func configureBarItemText(_ itemText: NavigationBarTextItem) -> UIBarButtonItem? {
		
		let buttonItem = UIBarButtonItem()
		buttonItem.title = itemText.title
		buttonItem.isEnabled = itemText.enabled
		
		if let textFont = barButtonItemTextFont(itemText) {
			buttonItem.setTitleTextAttributes(
				[ NSFontAttributeName: textFont ],
				for: .normal
			)
		}
		
		if let textColor = itemText.color {
			buttonItem.tintColor = textColor
		}
		
		buttonItem.actionClosure = itemText.onTapEvent
		
		return buttonItem
	}
	
	private func configureBarItemView(_ itemView: NavigationBarViewItem) -> UIBarButtonItem? {
		
		let buttonItem = UIBarButtonItem()
		buttonItem.customView = itemView.view
		buttonItem.isEnabled = itemView.enabled
		buttonItem.actionClosure = itemView.onTapEvent
		
		return buttonItem
	}
	
	private func configureBarItemImage(_ itemImage: NavigationBarImageItem) -> UIBarButtonItem? {
		
		let navigationBar = navigationController?.navigationBar
		
		guard let navigationBarHeight = navigationBar?.bounds.height,
			let image = itemImage.image else {
				return nil
		}
		
		let imageWidth = image.size.width
		let buttonFrame = CGRect(x: 0, y: 0, width: imageWidth, height: navigationBarHeight)
		
		let button = UIButton(frame: buttonFrame)
		button.setImage(image, for: .normal)
		button.actionClosure = itemImage.onTapEvent
		
		let buttonItem = UIBarButtonItem()
		buttonItem.customView = button
		buttonItem.isEnabled = itemImage.enabled
		
		return buttonItem
	}
	
	private func configureTitleBarTextAttributes(_ titleText: NavigationBarTextTitle) {
		
		var titleTextAttributes: [String: Any] = [:]
		
		if let labelFont = titleBarFont(titleText) {
			titleTextAttributes[NSFontAttributeName] = labelFont
		}
		
		if let labelColor = titleBarColor(titleText) {
			titleTextAttributes[NSForegroundColorAttributeName] = labelColor
		}
		
		if !titleTextAttributes.isEmpty {
			navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
		}
		
		navigationItem.title = titleText.text
	}
	
	private func titleBarColor(_ titleText: NavigationBarTextTitle) -> UIColor? {
		
		guard let labelColor = titleText.color else {
			return style.defaultTitleBarTextColor
		}
		
		return labelColor
	}
	
	private func titleBarFont(_ titleText: NavigationBarTextTitle) -> UIFont? {
		
		guard let labelFont = titleText.font else {
			return style.defaultFont
		}
		
		return labelFont
	}
	
	private func barButtonItemTextFont(_ itemText: NavigationBarTextItem) -> UIFont? {
		
		guard let itemTextFont = itemText.font else {
			return style.defaultFont
		}
		
		return itemTextFont
	}
	
}
