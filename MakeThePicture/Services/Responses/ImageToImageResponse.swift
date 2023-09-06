//
//  ImageToImageResponse.swift
//  MakeThePicture
//
//  Created by Илья Филяев on 01.06.2023.
//

import Foundation

struct ImageToImageResponse: Codable {
    let status: String
    let generationTime: Double
    let id: Int
    let output: [String]
    let meta: MetaImage
}

struct MetaImage: Codable {
    let h, w: Int
    let enableAttentionSlicing, filePrefix: String
    let guidanceScale: Double
    let model: String
    let nSamples: Int
    let negativePrompt, outdir, prompt, revision: String
    let safetyChecker: String
    let seed, steps: Int
    let vae: String

    enum CodingKeys: String, CodingKey {
        case h = "H"
        case w = "W"
        case enableAttentionSlicing = "enable_attention_slicing"
        case filePrefix = "file_prefix"
        case guidanceScale = "guidance_scale"
        case model
        case nSamples = "n_samples"
        case negativePrompt = "negative_prompt"
        case outdir, prompt, revision
        case safetyChecker = "safety_checker"
        case seed, steps, vae
    }
}
