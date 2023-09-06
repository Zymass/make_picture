//
//  MainViewModel.swift
//  MakeThePicture
//
//  Created by Илья Филяев on 29.05.2023.
//

import SwiftUI
import Combine

protocol TextToImageViewModelProtocol {
    var state: CurrentValueSubject<TextToImageState, Never> { get }
    var events: PassthroughSubject<TextToImageEvents, Never> { get }
    var input: PassthroughSubject<TextToImageInput, Never> { get }
}

class TextToImageViewModel: TextToImageViewModelProtocol {
    var state = CurrentValueSubject<TextToImageState, Never>(TextToImageState())
    var events = PassthroughSubject<TextToImageEvents, Never>()
    var input = PassthroughSubject<TextToImageInput, Never>()

    private lazy var networkManager = NetworkManager()
    private var cancellables = Set<AnyCancellable>()

    init() {
        events
            .sink { [weak self] events in
                guard let self else { return }

                switch events {
                case .textChanged(let text):
                    self.state.update(\.propt, to: text)
                case .mainButtonPressed:
//                    self.requestTextToImage()
                    self.uploadImage()
                }
            }
            .store(in: &cancellables)
    }

    private func requestTextToImage() {
        networkManager.requestTextToImage(
            prompt: self.state.value.propt,
            negativPrompt: self.state.value.negativePrompt
        ) { [weak self] response in
            guard let self, let response else { return }

            if
                let firstOutput = response.output.first,
                    !firstOutput.isEmpty,
                    let url = URL(string: firstOutput)
            {
                self.state.update(\.imageUrl, to: url)
                self.input.send(.requestCompleted)
            } else {
                self.networkManager.fetchImage(id: response.id) { response in
                    guard let imageUrlString = response?.output.first,
                            let url = URL(string: imageUrlString) else { return }
                    self.state.update(\.imageUrl, to: url)
                }
            }
        }
    }

    private func uploadImage() {
        guard let image = UIImage(named: "image_example") else { return }
        networkManager.uploadImage(image: image) { [weak self] response in
            guard let self, let response else { return }

            self.networkManager.requestImageToImage(
                prompt: "rainbow background",
                negativPrompt: nil,
                imageUrlString: response.link
            ) { response in
                guard let response else { return }
                if
                    let firstOutput = response.output.first,
                        !firstOutput.isEmpty,
                        let url = URL(string: firstOutput)
                {
                    self.state.update(\.imageUrl, to: url)
                    self.input.send(.requestCompleted)
                } else {
                    self.networkManager.fetchImage(id: response.id) { response in
                        guard let imageUrlString = response?.output.first,
                                let url = URL(string: imageUrlString) else { return }
                        self.state.update(\.imageUrl, to: url)
                    }
                }
            }
        }
    }
}

