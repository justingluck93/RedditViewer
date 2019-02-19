//
//  RedditPostDataModel.swift
//  RedditViewer
//
//  Created by JustinCaty<3 on 2/19/19.
//  Copyright © 2019 Justin. All rights reserved.
//

import UIKit

struct Reddit: Decodable {
    var kind: String
    var data: Children
}

struct Children: Decodable {
    var children: Array<Posts>
    var after: String
}

struct Posts:Decodable {
    //var kind: String
    var data: PostData
}

struct PostData: Decodable {
    var subreddit: String
    var title: String
    var permalink: String
}

class RedditPostDataModel {
    let session = URLSession.shared

    func getRedditPosts(subreddit: String = "", successCompletion: @escaping (Reddit) -> ()) {
        var url: URL
        if subreddit == "" {
            url = URL(string: "https://www.reddit.com/r/all/.json")!
        } else {
            guard let redditUrl = URL(string: "https://www.reddit.com/r/\(subreddit)/.json") else { return }
            url = redditUrl
        }
        
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(Reddit.self, from: data)
                    successCompletion(results)
                } catch {
                    print("Error \(error)")
                }
            }
            
    }.resume()
}
    
    func getMorePosts(subreddit: String = "", after: String, successCompletion: @escaping (Reddit) -> ()) {
        var url: URL
        if subreddit == "" {
            url = URL(string: "https://www.reddit.com/r/all/.json?limit=10&after=\(after)")!
        } else {
            guard let redditUrl = URL(string: "https://www.reddit.com/r/\(subreddit)/.json?limit=10&after=\(after)") else { return }
            url = redditUrl
        }
        
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(Reddit.self, from: data)
                    successCompletion(results)
                } catch {
                    print("Error \(error)")
                }
            }
            
            }.resume()
    }
    
}
