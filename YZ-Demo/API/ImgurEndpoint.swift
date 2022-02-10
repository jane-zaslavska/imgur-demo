//
//  ImgurEndpoint.swift
//  YZ-Demo
//
//  Created by Yevheniya Zaslavska on 10.02.2022.
//

import Foundation

enum Section: String {
    case popular, latest, oldest
}

enum Sort: String {
    case viral, top, time
}

enum Window: String {
    case day, week, month, year, all
}

enum ImgurEndpoint: Endpoint {
    
    case gallery(section: Section, sort: Sort, page: Int)
    case pics
    
    var httpMethod: HTTPMethod {
        switch self {
        case .gallery, .pics :
            return .get
        }
    }
    
    var baseUrl: String {
        return API.baseUrl.rawValue
    }

    var path: String {
        switch self {
        case .gallery(let section, let sort, let page):
            return "/gallery/\(section)/\(sort)/\(page)"
        case .pics:
            return "/gallery/r/pics"
        }
    }

    var urlParameters: [URLQueryItem]? {
        switch self {
        case .gallery, .pics:
            return nil
        }
    }
    
}
