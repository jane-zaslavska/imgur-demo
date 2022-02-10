//
//  APIClient.swift
//  YZ-Demo
//
//  Created by Yevheniya Zaslavska on 08.02.2022.
//

import Foundation

enum Either<T> {
    case success(T)
    case error(Error)
}

enum APIError: Error {
    case unknown,
         invalidResponse,
         emptyData,
         jsonDecodeFailed,
         imageDownloadFailed,
         imageConvertFailed
}

protocol APIClient {
    var session: URLSession { get }
    func get<T: Codable>(with request: URLRequest, completion: @escaping (Either<T>) -> Void)
}

extension APIClient {

    var session: URLSession {
        return URLSession.shared
    }

    func get<T: Codable>(with request: URLRequest, completion: @escaping (Either<T>) -> Void) {
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.error(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                completion(.error(APIError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.error(APIError.emptyData))
                return
            }

            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.error(APIError.jsonDecodeFailed))
                return
            }

            DispatchQueue.main.async {
                completion(.success(value))
            }
        }
        task.resume()
    }
}

