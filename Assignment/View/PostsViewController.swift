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


class PostsViewController: UIViewController {
    
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
    }
    

    private func setupRx() {
        
    }
}
