//
//  Collection+Extension.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        index >= startIndex && index < endIndex ? self[index] : nil
    }
}
