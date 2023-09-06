//
//  View+Extension.swift
//  MakeThePicture
//
//  Created by Илья Филяев on 31.05.2023.
//

import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}
