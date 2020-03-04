//
//  ViewController.swift
//  NotificationCenter
//
//  Created by Joaquim Pessoa Filho on 16/11/16.
//  Copyright © 2016 br.mackenzie.MackMobile. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var logTextArea: UITextView!
    @IBOutlet weak var dismissKeyboardButton: UIButton!
    
    var changeColorNotificationRef: NSObjectProtocol?
    var dismissKeyboardNotificationRef: NSObjectProtocol?
    var orientationDidChangeNotification: NSObjectProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearAction(self)
        
        // This Notification.name are specified in Extensions.swift file
        let changeColorNotificationName = Notification.Name.changeContainerViewColor
        
        // It's important if your notification handler needs to change something in the view
        // otherwise you need to use dispatch block to run your code in main queue
        let mainQueue = OperationQueue.main
        
        let center = NotificationCenter.default
        
        // Adding notification observer using BLOCK
        // it's necessary to remove
        self.changeColorNotificationRef = center.addObserver(forName: changeColorNotificationName, object: nil, queue: mainQueue, using: { (notification) in
            
            self.logTextArea.insertText("\tChangeContainerViewColor\n")
        })
        
        
        // Adding notification observer using BLOCK
        // it's necessary to remove
        self.dismissKeyboardNotificationRef = center.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: mainQueue, using: { (notification) in
            
            self.logTextArea.insertText("\tUIKeyboardDidShow\n")
            self.dismissKeyboardButton.isEnabled = true
        })
        
        // Adding notification observer using SELECTOR
        center.addObserver(self, selector: #selector(ViewController.keyboardDidHideNotification(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        
        // Adding notification observer using BLOCK
        self.orientationDidChangeNotification = center.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: mainQueue, using: { (notification) in
            
            self.logTextArea.insertText("\tUIDevice.orientationDidChange\n")
            self.logTextArea.insertText("\t\t\(UIDevice.current.orientation.isLandscape ? "IsLandscape\n" : "IsPortrait\n")")
        })
    }
    
    
    // Removing observer from NotificationCenter
    deinit {
        if let cn = self.changeColorNotificationRef {
            NotificationCenter.default.removeObserver(cn)
        }
        
        if let dn = self.dismissKeyboardNotificationRef {
            NotificationCenter.default.removeObserver(dn)
        }
    }


    
    @objc func keyboardDidHideNotification(notification: Notification) {
        self.logTextArea.insertText("\tUIKeyboardDidHide\n")
        self.dismissKeyboardButton.isEnabled = false
    }

    
    @IBAction func dismissKeyboardAction(_ sender: Any) {
        self.textField.resignFirstResponder()
    }

    
    @IBAction func changeColorAction(_ sender: Any) {
        let center = NotificationCenter.default
        center.post(name: Notification.Name.changeContainerViewColor, object: nil)
    }
    
    
    @IBAction func clearAction(_ sender: Any) {
        self.logTextArea.text = "Notifications are shown here\n"
    }
}

