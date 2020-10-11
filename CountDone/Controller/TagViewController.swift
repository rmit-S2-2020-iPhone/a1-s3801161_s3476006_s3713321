//
//  TagViewController.swift
//  CountDone
//
//  Created by Fanwei Wang on 9/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import UIKit



class TagViewController: UIViewController,Storyboarded {
    // tagview for user to choose from tags
    
    var coordinator: EventFlow?
    
    var tagViewModel = TagViewModel()
    
    @IBOutlet weak var tblview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblview.dataSource = self
        tblview.delegate = self
        tblview.reloadData()
    }

}

extension TagViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath) as? TagCell else{
            return UITableViewCell()
        }
        cell.configureTag(tag: tagViewModel.getTagsFor(at: indexPath.row))
        
        tagViewModel.configureSelect(at: cell, with: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tblview.cellForRow(at: indexPath)
        if tagViewModel.singleSelection(selectedCell: cell!,at: indexPath.row){
            tblview.reloadData()
            
        }
    }
    
    

}
