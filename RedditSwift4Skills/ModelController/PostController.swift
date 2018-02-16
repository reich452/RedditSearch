//
//  PostController.swift
//  RedditSwift4Skills
//
//  Created by Nick Reichard on 2/15/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import Foundation

class PostController {
    static let shared = PostController()
    
    private let baseURL = URL(string: "https://www.reddit.com/r/")
    
    var posts: [Post] = []
    
    typealias PostCompletionHandeler = (Post?, )
    
    func fetchPost(withSearchTerm: String, completion: @escaping () -> Void) {
        
    }
}
