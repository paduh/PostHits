//
//  PostsAPIClient.swift
//  Assignment
//
//  Created by Perfect Aduh on 27/02/2019.
//  Copyright © 2019 PAK Consulting. All rights reserved.
//

import Foundation
import RxSwift
import Moya_ModelMapper
import Moya

class PostsAPIClient {
    
    let provider: MoyaProvider<PostsEndPoint>!
    
    init(provider: MoyaProvider<PostsEndPoint>) {
        self.provider = provider
    }
    
    
    func fetchPosts(pageNumber: Int) -> Observable<Posts> {
        
        return provider.rx.request(PostsEndPoint.fetchPost(pageNumber: pageNumber)).debug().asObservable().map(to: Posts.self)
    }
}
