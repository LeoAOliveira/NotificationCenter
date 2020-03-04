//
//  ContainerViewController.swift
//  NotificationCenter
//
//  Created by Joaquim Pessoa Filho on 16/11/16.
//  Copyright © 2016 br.mackenzie.MackMobile. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    private var notificationReference: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuring view with default color
        self.view.backgroundColor = UIColor.lightGray
        
        
        // This Notification.name are specified in Extensions.swift file
        let notificationName = Notification.Name.changeContainerViewColor
        
        // It's important if your notification handler needs to change something in the view
        // otherwise you need to use dispatch block to run your code in main queue
        let mainQueue = OperationQueue.main
        
        let center = NotificationCenter.default
        
        // Adding notification observer using BLOCK
        // it's necessary to remove
        self.notificationReference = center.addObserver(forName: notificationName, object: nil, queue: mainQueue, using: { (notification) in
            
            if self.view.backgroundColor == UIColor.lightGray {
                UIView.animate(withDuration: 1, animations: {
                    self.view.backgroundColor = UIColor.green
                })
            } else {
                UIView.animate(withDuration: 1, animations: {
                    self.view.backgroundColor = UIColor.lightGray
                })
            }
        })
    }
    
    deinit {
        if let nr = self.notificationReference {
            NotificationCenter.default.removeObserver(nr)
        }
    }
}
