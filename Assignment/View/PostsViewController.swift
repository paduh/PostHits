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
        viewModel.fetchPosts()
    }
    

    private func setupRx() {
        
        viewModel
            .postsResponse
            .asObservable()
            .subscribe(onNext: { [weak self] (posts) in
                guard let strongSelf = self else { return }
                strongSelf.viewModel.postHits.accept(posts.hits)
                SVProgressHUD.dismiss()
            }, onError: { [weak self] (error) in
                guard let strongSelf = self else { return }
            }, onCompleted: {
                
            }) {
                
            }.disposed(by: bag)
        
        viewModel
            .postHits
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "bankListCell", cellType: PostsTableViewCell.self)) { row, bankList, cell in
//                cell.configureCell(bankList: bankList)
//                SVProgressHUD.dismiss()
            }.disposed(by: bag)
    }
}
