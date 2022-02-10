//
//  Image.swift
//  YZ-Demo
//
//  Created by Yevheniya Zaslavska on 09.02.2022.
//

import Foundation

typealias Images = [Image]

struct Image: Codable {
    let id: String
    let title: String
    let link: String
    let description: String?
    let score: Int
}

struct ImagesData: Codable {
    let data: Images
}
