//
//  PostsEndPoint.swift
//  Assignment
//
//  Created by Perfect Aduh on 27/02/2019.
//  Copyright © 2019 PAK Consulting. All rights reserved.
//

import Moya


enum PostsEndPoint {
    
    case fetchPost()
}


extension PostsEndPoint: TargetType {
    var baseURL: URL {
        switch self {
        case .fetchPost:
            return URL(string: Constant.baseUrl)!
        }
    }
    
    var path: String {
        switch self {
        case .fetchPost:
            return ""
        }
    }
    
    var method: Method {
        switch self {
        case .fetchPost:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .fetchPost:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .fetchPost:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchPost:
            return nil
        }
    }
}
