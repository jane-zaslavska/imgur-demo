//
//  ImgurClient.swift
//  YZ-Demo
//
//  Created by Yevheniya Zaslavska on 09.02.2022.
//

import Foundation

class ImgurClient: APIClient {

    func fetch(with endpoint: ImgurEndpoint, completion: @escaping (Either<ImagesData>) -> Void) throws {
        let request = try endpoint.asURLRequest()
        get(with: request, completion: completion)
    }
}
