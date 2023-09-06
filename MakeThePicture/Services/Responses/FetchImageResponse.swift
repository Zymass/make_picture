//
//  FetchImageResponse.swift
//  MakeThePicture
//
//  Created by Илья Филяев on 29.05.2023.
//

import Foundation

struct FetchImageResponse: Decodable {
    let status: String
    let id: Int
    let message: String
    let output: [String]
}
