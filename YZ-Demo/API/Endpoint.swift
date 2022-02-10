//
//  Endpoint.swift
//  YZ-Demo
//
//  Created by Yevheniya Zaslavska on 09.02.2022.
//

import Foundation

protocol Endpoint {
    var baseUrl: String { get }
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var urlParameters: [URLQueryItem]? { get }
    func asURLRequest() throws -> URLRequest
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
}

enum ContentType: String {
    case json = "application/json"
}

enum API: String {
    case baseUrl = "https://api.imgur.com/3"
    case clientID = "84a1186ed8ff0e8"
}

enum RequestError: Error {
    case parameterEncodingFailed
}


extension Endpoint {
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl
        print(url)
        
        guard let fullUrlString = url.appending(path).removingPercentEncoding,
            let fullUrl = URL(string: fullUrlString) else {
            throw RequestError.parameterEncodingFailed
        }
        
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = httpMethod.rawValue
        
        urlRequest.setValue("Client-ID \(API.clientID.rawValue)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        if let parameters = urlParameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw RequestError.parameterEncodingFailed
            }
        }
        
        return urlRequest
    }

}
