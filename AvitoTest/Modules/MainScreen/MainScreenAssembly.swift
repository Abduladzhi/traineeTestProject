//
//  MainScreenAssembly.swift
//  AvitoTest
//
//  Created by Abduladzhi on 29.10.2022.
//

import Foundation
import UIKit

final class MainScreenAssembly {
    
    static func assembleMainScreen() -> UIViewController {
        let view = MainVC()
        let dataConverter = MainDataConverter()
        let tableViewManager = MainTVManager()
        let networkManager = NetworkManager()
        let presenter = MainPresenter(dataConverter: dataConverter, networkManager: networkManager)
        view.presenter = presenter
        view.tableViewManager = tableViewManager
        presenter.view = view
        tableViewManager.delegate = presenter

        return view
    }
}
