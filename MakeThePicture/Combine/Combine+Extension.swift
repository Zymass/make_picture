//
//  Combine+Extension.swift
//  MakeThePicture
//
//  Created by Илья Филяев on 29.05.2023.
//

import Foundation
import Combine

protocol UpdatableStruct {
    func setup<T>(_ keyPath: WritableKeyPath<Self, T>, to value: T) -> Self
}

extension UpdatableStruct {
    func setup<T>(_ keyPath: WritableKeyPath<Self, T>, to value: T) -> Self {
        var updatedValue = self
        updatedValue[keyPath: keyPath] = value
        return updatedValue
    }
}

extension CurrentValueSubject where Output: UpdatableStruct {
    func update<T>(_ keyPath: WritableKeyPath<Output, T>, to newValue: T) {
        self.send(value.setup(keyPath, to: newValue))
    }
}
