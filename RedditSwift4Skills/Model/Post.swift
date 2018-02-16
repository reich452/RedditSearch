//
//  Post.swift
//  RedditSwift4Skills
//
//  Created by Nick Reichard on 2/15/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import Foundation

struct JsonDictionary: Decodable {
    
    let data: DataDictionary

    
    struct DataDictionary: Decodable {
        let children: [PostDictionary]
        
        struct PostDictionary: Decodable {
            let data: Post
            
        }
    }
}

struct Post: Decodable {
    
    // MARK: - Properties
    
    let title: String?
    let upVotes: Int?
    let author: String?
    let thumbnail: String?
    
    // MARK: - Private
    
    private enum CodingKeys: String, CodingKey {
        case title
        case upVotes = "ups"
        case author
        case thumbnail
    }
}
