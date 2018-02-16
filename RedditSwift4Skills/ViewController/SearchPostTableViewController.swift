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
        tableView.estimatedRowHeight = 300
        
    }
    
    // MARK: - Delegates
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchBar.resignFirstResponder()
        
        PostController.shared.fetchPost(with: searchText) { (posts, error) in
            
            DispatchQueue.main.async { [weak self] in
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                self?.tableView.reloadData()
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
                cell.imageView?.image = newImage
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
            guard let postImageUrl = post.thumbnail else { return }
            
            URLSession.shared.dataTask(with: postImageUrl)
            print("Prefetching \(post.title)")
        }
    }
}



