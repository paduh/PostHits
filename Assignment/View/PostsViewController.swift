//
//  PostsViewController.swift
//  Assignment
//
//  Created by Perfect Aduh on 27/02/2019.
//  Copyright © 2019 PAK Consulting. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import Moya
import SVProgressHUD


class PostsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let viewModel: PostsViewModel!
    let apiClient: PostsAPIClient!
    let provider: MoyaProvider<PostsEndPoint>!
    let bag = DisposeBag()
    
    required init?(coder aDecoder: NSCoder) {
        provider = MoyaProvider<PostsEndPoint>()
        apiClient = PostsAPIClient(provider: provider)
        viewModel = PostsViewModel(apiClient: apiClient)
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupRx()
        setupView()
    }
    
    private func setupView() {
        SVProgressHUD.show()
        viewModel.fetchPosts(pageNumber: viewModel.currentPage)
        
        tableView.delegate = self
        tableView.register(UINib.init(nibName: PostsTableViewCell.name, bundle: nil), forCellReuseIdentifier: PostsTableViewCell.name)
        tableView.rowHeight = 120
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    

    private func setupRx() {
        
        viewModel
            .postsResponse
            .asObservable()
            .subscribe(onNext: { [weak self] (posts) in
                guard let strongSelf = self else { return }
                strongSelf.viewModel.postHits.accept(posts.hits)
                strongSelf.navigationController?.navigationBar.topItem?.title = (" Listing \(strongSelf.viewModel.postHits.value.count)  Posts")
                SVProgressHUD.dismiss()
            }, onError: { [weak self] (error) in
                guard let strongSelf = self else { return }
                strongSelf.showAlert(message: error.localizedDescription)
            }, onCompleted: {
                
            }) {
                
            }.disposed(by: bag)
        
        self.viewModel
            .postHits
            .asObservable()
            .bind(to: self.tableView.rx.items(cellIdentifier: PostsTableViewCell.name, cellType: PostsTableViewCell.self)) { row, post, cell in
                cell.configureCell(post: post)
                SVProgressHUD.dismiss()
            }.disposed(by: self.bag)
        
        
    }
    
    private func loadMore() {
        viewModel.isLoading = true
       // SVProgressHUD.show()
        self.viewModel.fetchPosts(pageNumber: self.viewModel.currentPage)
    }
    
    
}


extension PostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("EENE")
        let lastPost = viewModel.postHits.value.count - 1
        if !viewModel.isLoading && indexPath.row == lastPost {

        }
    }
}
