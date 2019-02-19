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
    var after: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = .done
        
        getRedditPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)

    }
    
    func getRedditPosts(subreddit: String = "") {
        redditPost.getRedditPosts(subreddit: subreddit)  { (RedditData) in
             DispatchQueue.main.sync {
                self.after = RedditData.data.after
                self.redditPosts = [Posts](RedditData.data.children)
                self.tableView.reloadData()
            }
        }
    }

    func getMorePosts(subreddit: String = "", after: String) {
        DispatchQueue.global(qos: .background).async {
            self.redditPost.getMorePosts(subreddit: subreddit, after: after)  { (RedditData) in
                DispatchQueue.main.sync {
                    self.after = RedditData.data.after
                    self.redditPosts =  self.redditPosts! + [Posts](RedditData.data.children)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueToPost = segue.destination as? RedditPostWebView {
            guard let urlString = redditPosts?[(tableView.indexPathForSelectedRow?.row)!].data.permalink else { return }
            segueToPost.url = urlString
        }
    }
}

extension RedditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "loadRedditPost", sender: self)
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
        
        if indexPath.row == (self.redditPosts?.count)! - 1 {
            self.getMorePosts(subreddit: searchBar.text!, after: self.after!)
        }
        
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

