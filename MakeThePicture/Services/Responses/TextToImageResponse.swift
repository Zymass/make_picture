//
//  TextToImageResponse.swift
//  MakeThePicture
//
//  Created by Илья Филяев on 28.05.2023.
//

import Foundation

struct TextToImageResponse: Decodable {
    let status: String
    let generationTime: Double?
    let id: Int
    let output: [String]
    let meta: MetaText
}

struct MetaText: Decodable {
    let prompt, modelID, negativePrompt, scheduler: String?
    let safetyChecker: String?
    let w, h: Int?
    let guidanceScale: Double?
    let seed, steps, nSamples: Int?
    let fullURL, tomesd, upscale, multiLingual: String?
    let panorama, selfAttention, useKarrasSigmas: String?
    let embeddings, vae, lora: String?
    let loraStrength: Int?
    let filePrefix: String?

    enum CodingKeys: String, CodingKey {
        case prompt
        case modelID = "model_id"
        case negativePrompt = "negative_prompt"
        case scheduler
        case safetyChecker = "safety_checker"
        case w = "W"
        case h = "H"
        case guidanceScale = "guidance_scale"
        case seed, steps
        case nSamples = "n_samples"
        case fullURL = "full_url"
        case tomesd, upscale
        case multiLingual = "multi_lingual"
        case panorama
        case selfAttention = "self_attention"
        case useKarrasSigmas = "use_karras_sigmas"
        case embeddings, vae, lora
        case loraStrength = "lora_strength"
        case filePrefix = "file_prefix"
    }
}
