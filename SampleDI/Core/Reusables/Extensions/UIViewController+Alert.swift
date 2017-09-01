//
//  UIViewController+Extension.swift
//  SampleDI
//
//  Created by Nanda Julianda Akbar on 8/23/17.
//  Copyright © 2017 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
	
	func showAlert(title: String,
	               message: String,
	               action: UIAlertAction) {
		
		showAlert(
			title: title,
			message: message,
			actions: [action]
		)
	}
	
	func showAlert(title: String,
	               message: String,
	               actions: [UIAlertAction]) {
		
		let alertController = UIAlertController(
			title: title,
			message: message,
			preferredStyle: UIAlertControllerStyle.alert
		)
		
		for alertAction in actions {
			alertController.addAction(alertAction)
		}
		
		present(alertController, animated: true)
	}
	
}
