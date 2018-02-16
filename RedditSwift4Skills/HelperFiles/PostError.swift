//
//  PostError.swift
//  RedditSwift4Skills
//
//  Created by Nick Reichard on 2/15/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import Foundation

enum PostError: Error {
    case invalidUrl
    case requestFailed
    case jsonConversionFailure
    case imageDataFailure
}
