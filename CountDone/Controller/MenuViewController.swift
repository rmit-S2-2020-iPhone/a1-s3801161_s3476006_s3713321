//
//  MenuViewController.swift
//  CountDone
//
//  Created by Fanwei Wang on 11/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case home
    case logout
}
class MenuViewController: UITableViewController {
    //the memu for side bar
    var didTapMenuType: ((MenuType) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else {return}
        dismiss(animated: true){[weak self] in
            self?.didTapMenuType?(menuType)
        }
    }
}

