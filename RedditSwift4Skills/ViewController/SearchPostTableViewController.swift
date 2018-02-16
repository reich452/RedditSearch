//
//  SearchPostTableViewController.swift
//  RedditSwift4Skills
//
//  Created by Nick Reichard on 2/15/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit

class SearchPostTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.prefetchDataSource = self
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
    }
    
    // MARK: - Delegates
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchBar.resignFirstResponder()
        
        PostController.shared.fetchPost(with: searchText) { (posts, error) in
            
            DispatchQueue.main.async { [weak self] in
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                self?.tableView.reloadData()
                searchBar.text = "" 
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PostController.shared.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? SearchPostTableViewCell else { return UITableViewCell() }
        
        let post = PostController.shared.posts[indexPath.row]
        cell.post = post
        PostController.shared.fetchPostImage(post: post) { (newImage, error) in
            DispatchQueue.main.async {
                cell.post = post
                if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath == indexPath {
                    
                    if cell.postImageView.image == nil {
                       cell.postImageView.image = #imageLiteral(resourceName: "redditDefaultImage")
                    } else {
                        cell.postImageView.image = newImage
                        cell.thumbnail = newImage
                    }
                } else {
                    return 
                }
            }
        }

        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension SearchPostTableViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let post = PostController.shared.posts[indexPath.row]
            guard let postThumbnail = post.thumbnail,
                let postUrl = URL(string: postThumbnail) else { return }

            URLSession.shared.dataTask(with: postUrl)
            print("Prefetching \(post.title ?? "no prefetch")")
        }
    }
}



