//
//  MainViewEvents.swift
//  MakeThePicture
//
//  Created by Илья Филяев on 29.05.2023.
//

import Foundation

struct TextToImageState: UpdatableStruct {
    var propt = ""
    var negativePrompt = ""
    var imageUrl = URL(string: "")
}

enum TextToImageEvents {
    case textChanged(text: String)
    case mainButtonPressed
}

enum TextToImageInput {
    case requestCompleted
}

//enum AuthorizatioOutput {
//    case showSmsScreen(phone: String)
//    case showAlert(title: String, message: String)
//}
