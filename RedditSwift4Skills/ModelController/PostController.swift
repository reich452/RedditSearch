//
//  PostController.swift
//  RedditSwift4Skills
//
//  Created by Nick Reichard on 2/15/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit

class PostController {
    static let shared = PostController()
    
    private let baseURL = URL(string: "https://www.reddit.com/r/")
    
    var posts = [Post]()
    
    typealias PostCompletionHandeler = ([Post]?, PostError?) -> Void
    
    func fetchPost(with searchTerm: String, completion: @escaping PostCompletionHandeler) {
        
        guard let url = baseURL else { completion(nil,.invalidUrl); return }
        let requetUrl = url.appendingPathComponent(searchTerm).appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requetUrl) { (data, _, error) in
            
            do {
                
                if let error = error { throw error }
                guard let data = data else { throw NSError() }
                
                let postDictionaries = try JSONDecoder().decode(JsonDictionary.self, from: data).data.children
                let posts = postDictionaries.flatMap{$0.data}
                
                self.posts = posts
                completion(posts, nil)
                
            } catch let error {
                print("Error fethcing post \(error.localizedDescription) \(error) \(#function)")
                completion(nil,.jsonConversionFailure)
            }
        }.resume()
    }
    
    func fetchPostImage(post: Post, completion: @escaping (UIImage?, PostError?) -> Void) {
        guard let postThumbnail = post.thumbnail,
            let imageUrl = URL(string: postThumbnail) else { return }
        
        URLSession.shared.dataTask(with: imageUrl) { (data, _, error) in
            
            do {
                if let error = error { throw error }
                guard let data = data else {throw NSError() }
                
                let image = UIImage(data: data)
                completion(image, nil)
                
            } catch let error {
                print("Error fethcing image from task \(error.localizedDescription) \(error) \(#function)")
                completion(nil, .imageDataFailure)
            }
            
        }.resume()
    }
}








