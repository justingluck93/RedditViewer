//
//  RedditViewController.swift
//  RedditViewer
//
//  Created by Justin 2/19/19.
//  Copyright © 2019 Justin. All rights reserved.
//

import UIKit

class RedditViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var redditPost = RedditPostDataModel()
    var redditPosts: [Posts]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = .done
        
        getRedditPosts()
    }
    
    func getRedditPosts(subreddit: String = "") {
        redditPost.getRedditPosts(subreddit: subreddit)  { (RedditData) in
             DispatchQueue.main.sync {
                self.redditPosts = [Posts](RedditData.data.children)
                self.tableView.reloadData()
            }
        }
    }
}

extension RedditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let postLink = redditPosts?[indexPath.row].data.permalink else { return }
        guard let url = URL(string: "https://www.reddit.com\(postLink)") else { return }
        UIApplication.shared.open(url)
    }
}

extension RedditViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = redditPosts?.count else { return 0 }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "redditPost", for: indexPath)
        myCell.textLabel?.text = redditPosts![indexPath.row].data.title
        myCell.detailTextLabel?.text = "Subreddit: \(redditPosts![indexPath.row].data.subreddit)"
        return myCell
    }
}

extension RedditViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        getRedditPosts(subreddit: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
