//
//  Tag.swift
//  CountDone
//
//  Created by Fanwei Wang on 10/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import Foundation
struct Tag{
    var tagEmoji:String
    var tagName:String
}
struct TagList{
    var tags:[Tag] = [Tag(tagEmoji: "⚽️", tagName: "Sports"),Tag(tagEmoji: "🏫", tagName: "Study"),Tag(tagEmoji: "🛒", tagName: "Shopping"),Tag(tagEmoji: "🎂", tagName: "Anniversary"),Tag(tagEmoji: "💼", tagName: "Work"),Tag(tagEmoji: "💅", tagName: "Skincare"),Tag(tagEmoji: "🕹", tagName: "Game")]
    
    func getTag(tagEmoji: String) -> Tag {
        for i in 0..<tags.count{
            if tags[i].tagEmoji == tagEmoji{
                return tags[i]
            }
        }
        return Tag(tagEmoji: "❗️", tagName: "No Such Tag")
    }
    
    func getTagIndex(tag: Tag) -> Int{
        for i in 0..<tags.count{
            if tags[i].tagEmoji == tag.tagEmoji{
                return i
            }
        }
        return -1
    }
}
