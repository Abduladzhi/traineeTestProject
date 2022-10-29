//
//  MainViewModel.swift
//  AvitoTest
//
//  Created by Abduladzhi on 29.10.2022.
//

import Foundation

struct MainViewModel {
    
    let rows: [Row]

    struct Row {

        let configurator: TableCellConfiguratorProtocol

        var reuseId: String {
            return type(of: configurator).reuseId
        }
    }
}
