//
//  ContentView.swift
//  MakeThePicture
//
//  Created by Илья Филяев on 28.05.2023.
//

import SwiftUI
import Kingfisher

struct TextToImageView: View {

    private let viewModel: TextToImageViewModelProtocol

    @State var imageUrl: URL? = nil
    @State var isMainButtonDisabled: Bool = false
    @FocusState private var textFieldIsFocused: Bool

    init(viewModel: TextToImageViewModelProtocol) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            ZStack {
                ProgressView()
                    .isHidden(!isMainButtonDisabled)
                    .scaleEffect(5)
                KFImage.url(imageUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            Spacer()
            Button("Send REQUEST") {
                viewModel.events.send(.mainButtonPressed)
                isMainButtonDisabled = true
                textFieldIsFocused = false
            }
            .disabled(isMainButtonDisabled)
            TextField("Enter your request", text: Binding<String>(
                get: {viewModel.state.value.propt},
                set: {viewModel.events.send(.textChanged(text: $0))}))
                .textFieldStyle(.roundedBorder)
                .focused($textFieldIsFocused)
                .disabled(isMainButtonDisabled)
        }
        .onReceive(viewModel.state) {_ in
            imageUrl = viewModel.state.value.imageUrl
        }
        .onReceive(viewModel.input) { events in
            switch events {
            case .requestCompleted:
                isMainButtonDisabled = false
            }
        }
        .padding()
        .background(Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TextToImageView(viewModel: TextToImageViewModel())
    }
}
