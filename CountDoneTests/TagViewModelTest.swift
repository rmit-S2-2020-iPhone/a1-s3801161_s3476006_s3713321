//
//  TagViewModel.swift
//  CountDoneTests
//
//  Created by Fanwei Wang on 11/10/20.
//  Copyright © 2020 G33. All rights reserved.
//

import XCTest
@testable import CountDone

class TagViewModelTest: XCTestCase {

    var tagViewModel: TagViewModel?
    
    
    override func setUp() {
        tagViewModel = TagViewModel()
    }

    override func tearDown() {
        tagViewModel = nil
    }

    func testSetTag() {
        let tag1 = Tag(tagEmoji: "🕹", tagName: "Game")
        let tag2 = Tag(tagEmoji: "xxx", tagName: "XXX")
        
        tagViewModel?.setTag(tag: tag1)
        XCTAssertEqual(tagViewModel?.selectedIndex[0], 6)
        XCTAssertEqual(tagViewModel?.selectedIndex.count, 1)
        tagViewModel?.setTag(tag: tag2)
        XCTAssertEqual(tagViewModel?.selectedIndex[1], 0)
        XCTAssertEqual(tagViewModel?.selectedIndex.count, 2)
    }
    
    func testSingleSelectionSuccess(){
        let cell  = UITableViewCell()
        
        let didsomething = tagViewModel?.singleSelection(selectedCell: cell, at: 5)
        XCTAssertTrue(didsomething!)
        
        
    }
    func testSingleSelectionFalse(){
        let cell  = UITableViewCell()
        tagViewModel?.selectedIndex.append(6)
        
        let didsomething = tagViewModel?.singleSelection(selectedCell: cell, at: 6)
        XCTAssertFalse(didsomething!)
    }
    
    



}
