//
//  Configurable.swift
//  AvitoTest
//
//  Created by Abduladzhi on 29.10.2022.
//

import Foundation

protocol Configurable {
    associatedtype Model
    func configure(with model: Model)
}
