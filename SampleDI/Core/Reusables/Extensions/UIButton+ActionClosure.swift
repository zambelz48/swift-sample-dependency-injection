//
//  UIButton+ActionClosure.swift
//  My Blue Bird
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
	
	private struct AssociatedObject {
		static var key = "UIButton_ActionClosure"
	}
	
	var actionClosure: (() -> Void)? {
		
		get {
			return objc_getAssociatedObject(self, &AssociatedObject.key) as? () -> Void
		}
		
		set {
			
			objc_setAssociatedObject(self, &AssociatedObject.key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			
			addTarget(
				self,
				action: #selector(buttonTapped(sender:)),
				for: .touchUpInside
			)
		}
		
	}
	
	@objc private func buttonTapped(sender: Any) {
		actionClosure?()
	}
	
}
