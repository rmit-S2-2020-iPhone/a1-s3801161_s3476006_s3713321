//
//  ContainerController.swift
//  CountDone
//
//  Created by Changyu on 10/10/20.
//  Copyright © 2020 G33. All rights reserved.
//
// reference: https://www.youtube.com/watch?v=dB-vB9uDRCI

import UIKit

class ContainerController: UIViewController {
    
    // MARK: -Properties
    
    var menuController: UIViewController!
    var centerController: UIViewController!
    var isExpanded = false
    
    // MARK: -Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureEventController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: -Handlers
    
    func configureEventController() {
        let eventController = EventViewController()
        eventController.delegate = self
        centerController = UINavigationController(rootViewController: eventController)

        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    func configureMenuController() {
        if menuController == nil {
            // add menu controller
            menuController = MenuController()
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
//            print("hi")
        }
    }
    
    func showMenu(shouldExpand: Bool) {
        if shouldExpand {
            // show menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
            }, completion: nil)
        } else {
            // hide menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }, completion: nil)
        }
    }
}

extension ContainerController: SideBarDelegate {

    func handleMenu() {
        if !isExpanded {
            configureMenuController()
        }
        isExpanded = !isExpanded
        showMenu(shouldExpand: isExpanded)
    }
}
