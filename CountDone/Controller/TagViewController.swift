//
//  TagViewController.swift
//  CountDone
//
//  Created by Fanwei Wang on 9/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit

class TagViewController: UIViewController {

    var tags:[String:String] = ["🏃":"play"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

extension TagViewController: UITableViewDataSource,UITabBarDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath)
        
        return cell
    }
    
    
}
