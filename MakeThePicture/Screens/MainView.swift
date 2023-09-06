//
//  TabBarView.swift
//  MakeThePicture
//
//  Created by Илья Филяев on 31.05.2023.
//

import SwiftUI

struct MainView: View {

    let mainViewModel = TextToImageViewModel()

    var body: some View {
        TabView {
            TextToImageView(viewModel: mainViewModel)
                .tabItem {
                    Label("Text2Image", systemImage: "text.bubble")
                }
            ImageToImageView()
                .tabItem {
                    Label("Image2Image", systemImage: "photo.circle")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
