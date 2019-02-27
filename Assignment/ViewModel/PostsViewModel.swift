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
    
    func fetchPosts(pageNumber: Int)
}

class PostsViewModel {
    
    let bag: DisposeBag!
    let apiClient: PostsAPIClient!
    
    var postsResponse = BehaviorRelay<Posts>(value: Posts(hits: []))
    var postHits = BehaviorRelay<[PostHits]>(value: [PostHits(createdAt: "", title: "")])
    var postsComplete: ((String?) ->())?
    var currentPage = 0
    var pageNumber = 1
    var isLoading = false
    
    init(apiClient: PostsAPIClient) {
        self.apiClient = apiClient
        bag = DisposeBag()
        
        currentPage += pageNumber
    }
}

extension PostsViewModel: Postable {
    
    func fetchPosts(pageNumber: Int) {
        
        apiClient
            .fetchPosts(pageNumber: pageNumber)
            .asObservable()
            .subscribe(onNext: { [weak self] (posts) in
                guard let strongSelf = self else { return }
                strongSelf.postsResponse.accept(posts)
                strongSelf.postsComplete?(nil)
                strongSelf.isLoading = false
                }, onError: { [weak self] (error) in
                    guard let strongSelf = self else { return }
                    strongSelf.postsComplete?(error.localizedDescription)
            }, onCompleted: {
                
            }) {
                
            }.disposed(by: bag)
        
        
    }
}
