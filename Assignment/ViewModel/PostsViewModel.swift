//
//  PostsViewModel.swift
//  Assignment
//
//  Created by Perfect Aduh on 27/02/2019.
//  Copyright © 2019 PAK Consulting. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol Postable {
    
    func fetchPosts()
}

class PostsViewModel {
    
    let bag: DisposeBag!
    let apiClient: PostsAPIClient!
    
    var postsResponse = BehaviorRelay<Posts>(value: Posts(hits: []))
    var postHits = BehaviorRelay<[PostHits]>(value: [PostHits(createdAt: "", title: "")])
    var postsComplete: ((String?) ->())?
    
    init(apiClient: PostsAPIClient) {
        self.apiClient = apiClient
        bag = DisposeBag()
    }
}

extension PostsViewModel: Postable {
    
    func fetchPosts() {
        
        apiClient
            .fetchPosts()
            .asObservable()
            .subscribe(onNext: { [weak self] (posts) in
                guard let strongSelf = self else { return }
                strongSelf.postsResponse.accept(posts)
                strongSelf.postsComplete?(nil)
                }, onError: { [weak self] (error) in
                    guard let strongSelf = self else { return }
                    strongSelf.postsComplete?(error.localizedDescription)
            }, onCompleted: {
                
            }) {
                
            }.disposed(by: bag)
        
        
    }
}
