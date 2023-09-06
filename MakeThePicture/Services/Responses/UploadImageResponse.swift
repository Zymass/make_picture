//
//  UploadImageResponse.swift
//  MakeThePicture
//
//  Created by Илья Филяев on 01.06.2023.
//

import Foundation

struct UploadImageResponse: Decodable {
    let status: String
    let messege: String
    let link: String
    let request_id: Int
}
