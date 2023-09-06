//
//  NetworkManager.swift
//  MakeThePicture
//
//  Created by Илья Филяев on 28.05.2023.
//

import Foundation
import Alamofire

final class NetworkManager {

    let decoder = JSONDecoder()
    let accessKey = "Xg1DySGHAkq5GcftYzv3kCwJigG3VfNHGuwBMcBM9flzu77smKXYdp4r728V"

    func requestTextToImage(
        prompt: String,
        negativPrompt: String?,
        completion: @escaping (TextToImageResponse?) -> ()
    ) {
        let url = "https://stablediffusionapi.com/api/v3/text2img"

        let parameters: [String: String?] = [
          "key": accessKey,
          "prompt": prompt,
          "negative_prompt": negativPrompt,
          "width": "512",
          "height": "512",
          "samples": "1",
          "num_inference_steps": "20",
          "safety_checker": "no",
          "enhance_prompt": "yes",
          "seed": nil,
          "guidance_scale": "7.5",
          "multi_lingual": "no",
          "panorama": "no",
          "self_attention": "no",
          "upscale": "no",
          "embeddings_model": "embeddings_model_id",
          "webhook": nil,
          "track_id": nil
        ]

        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default
        ).response { [weak self] response in

            guard let self else { return }

            switch response.result {
            case .success(let data):
                guard let data else { return }

                print("✈️\(response)")

                do {
                    let response = try self.decoder.decode(
                        TextToImageResponse.self,
                        from: data
                    )
                    completion(response)
                } catch {
                    completion(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }

    func fetchImage(
        id: Int,
        completion: @escaping (FetchImageResponse?) -> ()
    ) {
        let url = "https://stablediffusionapi.com/api/v4/dreambooth/fetch"

        let parameters: [String: String?] = [
            "key": accessKey,
            "request_id": String(id)
        ]

        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default
        ).response { [weak self] response in
            guard let self else { return }
            print("✈️\(response)")

            switch response.result {
            case .success(let data):
                guard let data else { return }

                do {
                    let response = try self.decoder.decode(
                        FetchImageResponse.self,
                        from: data
                    )
                    completion(response)
                } catch {
                    completion(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }

    func uploadImage(
        image: UIImage,
        completion: @escaping (UploadImageResponse?) -> ()
    ) {
        let url = "https://stablediffusionapi.com/api/v3/base64_crop"
        guard let imageData = image.jpegData(compressionQuality: 1) else { return }
        let base64Image = imageData.base64EncodedString()

        let parameters: [String: Any] = [
            "key": accessKey,
            "image": "data:image/png;base64,\(base64Image)",
            "crop": "true"
        ]

        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type": "application/json"]
        ).response { [weak self] response in
            guard let self else { return }
            print("✈️\(response)")

            switch response.result {
            case .success(let data):
                guard let data else { return }

                do {
                    let response = try self.decoder.decode(
                        UploadImageResponse.self,
                        from: data
                    )
                    completion(response)
                } catch {
                    completion(nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func requestImageToImage(
        prompt: String,
        negativPrompt: String?,
        imageUrlString: String,
        completion: @escaping (ImageToImageResponse?) -> ()
    ) {
        let url = "https://stablediffusionapi.com/api/v3/img2img"

        let parameters: [String: String?] = [
            "key": accessKey,
            "prompt": prompt,
            "negative_prompt": negativPrompt,
            "init_image": imageUrlString,
            "width": "512",
            "height": "512",
            "samples": "1",
            "num_inference_steps": "30",
            "safety_checker": "no",
            "enhance_prompt": "yes",
            "guidance_scale": "7.5",
            "strength": "0.7",
            "seed": nil,
            "webhook": nil,
            "track_id": nil
        ]

        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default
        ).response { [weak self] response in
            guard let self else { return }
            print("✈️\(response)")

            switch response.result {
            case .success(let data):
                guard let data else { return }

                do {
                    let response = try self.decoder.decode(
                        ImageToImageResponse.self,
                        from: data
                    )
                    completion(response)
                } catch {
                    completion(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
