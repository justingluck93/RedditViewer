//
//  RedditViewerTests.swift
//  RedditViewerTests
//
//  Created by JustinCaty on 2/19/19.
//  Copyright © 2019 Justin. All rights reserved.
//

import XCTest
@testable import RedditViewer

class RedditViewerTests: XCTestCase {
    
    var subject: MockRedditViewController?
    
    override func setUp() {
        subject = MockRedditViewController()
    }

    override func tearDown() {
    }

    func testRedditViewControllerHasATableView() {
        let redditViewer = UIStoryboard(name: "Main", bundle: Bundle(for: RedditViewController.self)).instantiateViewController(withIdentifier: "RedditViewController") as! RedditViewController
        redditViewer.loadViewIfNeeded()
        XCTAssertNotNil(redditViewer.tableView)
    }
    
    func testRedditViewControllerHasASearchBar() {
        let redditViewer = UIStoryboard(name: "Main", bundle: Bundle(for: RedditViewController.self)).instantiateViewController(withIdentifier: "RedditViewController") as! RedditViewController
        redditViewer.loadViewIfNeeded()
        XCTAssertNotNil(redditViewer.searchBar)
    }
}

class  MockRedditViewController: RedditViewController {
    var getPostsWasCalled = false
    
    override func getRedditPosts(subreddit: String = "") {
        getPostsWasCalled = true
    }
}

class  MockRedditPostDataModel: RedditPostDataModel {
    var getRedditPostsWasCalled = false
    
    override func getRedditPosts(subreddit: String, successCompletion: @escaping (Reddit) -> ()) {
        getRedditPostsWasCalled = true
    }
}
