//
//  CollectionExt.swift
//  AvitoTest
//
//  Created by Abduladzhi on 29.10.2022.
//

extension Collection {
    
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

