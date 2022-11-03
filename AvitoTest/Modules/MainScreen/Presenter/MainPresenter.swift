//
//  MainPresenter.swift
//  AvitoTest
//
//  Created by Abduladzhi on 29.10.2022.
//

import Foundation

protocol MainVCOutput {
    func viewIsReady()
}

final class MainPresenter {
    weak var view: MainVCInput?
    private let dataConverter: MainDataConverterInput?
    private let networkManager: NetworkManager?
    private let userDefaults = UserDefaults.standard
    
    init(dataConverter: MainDataConverterInput, networkManager: NetworkManager) {
        self.dataConverter = dataConverter
        self.networkManager = networkManager
    }
}

extension MainPresenter: MainVCOutput {
    func viewIsReady() {
        
        networkManager?.request(fromURL: URL(string: App.url)!, completion: { (result: Result<MainModel, Error>) in
            switch result {
            case .success(let items):
                self.userDefaults.setCodableObject(items, forKey: "data")
                self.userDefaults.setCodableObject(Date() + 3600, forKey: "date")
                guard let viewModel = self.dataConverter?.convert(data: items, delegate: self) else { return }
                self.view?.success(viewModel: viewModel, delegate: self)
                
            case .failure(let error):
                let myArrey = self.userDefaults.codableObject(dataType: MainModel.self, key: "data")
                let localeDate = self.userDefaults.codableObject(dataType: Date.self, key: "date")
                if myArrey != nil && localeDate ?? Date() >= Date() {
                    guard let viewModel = self.dataConverter?.convert(data: myArrey ?? MainModel.init(company: Company.init(name: "", employees: [Employees.init(name: "", phone_number: "", skills: [""])])), delegate: self) else { return }
                    self.view?.success(viewModel: viewModel, delegate: self)
                } else {
                    self.view?.failure(error: error)
                }
            }
        })
    }
}

extension MainPresenter: MainTVManagerDelegate {
}
