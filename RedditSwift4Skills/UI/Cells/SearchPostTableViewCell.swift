//
//  SearchPostTableViewCell.swift
//  RedditSwift4Skills
//
//  Created by Nick Reichard on 2/15/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit

class SearchPostTableViewCell: UITableViewCell {

    @IBOutlet weak var upVoteLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    
    // MARK: - Properties
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    var thumbnail: UIImage? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let post = post else { return }
        titleLabel.text = post.title
        authorLabel.text = post.author
        upVoteLabel.text = "\(post.upVotes ?? 0)"
        if let thumbnail = thumbnail {
            postImageView.image = thumbnail
        } else {
            postImageView.image = #imageLiteral(resourceName: "redditDefaultImage")
        }
    }
}
