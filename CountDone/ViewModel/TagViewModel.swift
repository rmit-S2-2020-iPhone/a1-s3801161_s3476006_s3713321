//
//  TagViewModel.swift
//  CountDone
//
//  Created by Fanwei Wang on 10/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation
import UIKit


struct TagViewModel {
    
    let tagList = TagList()
    
    var createVC:CreateTaskTableViewController?
    
    var count:Int {
        return tagList.tags.count
    }
   
    
    var selectedIndex:[Int] = []
    
    var tag: Tag?
    
    mutating func setTag(tag: Tag){
        self.tag = tag
        if tagList.getTag(tagEmoji: tag.tagEmoji).tagEmoji == "❗️"{
            selectedIndex.append(0)
        } else{
            selectedIndex.append(tagList.getTagIndex(tag: tag))
        }
    }
    
    func getTagsFor(at index: Int) -> Tag{
        return tagList.tags[index]
    }
    
    mutating func singleSelection(selectedCell cell: UITableViewCell,at index: Int) -> Bool{
        if !selectedIndex.contains(index){
            cell.accessoryType = .checkmark
            selectedIndex.removeAll()
            selectedIndex.append(index)
            createVC?.tagName.text  = tagList.tags[selectedIndex[0]].tagName
            createVC?.TagLabel.text = tagList.tags[selectedIndex[0]].tagEmoji
            return true
        }
        return false
    }
    
    func configureSelect(at cell: UITableViewCell,with index: Int){
        if selectedIndex.contains(index){
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
    }
}
