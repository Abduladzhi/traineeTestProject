//
//  MainVC.swift
//  AvitoTest
//
//  Created by Abduladzhi on 29.10.2022.
//

import Foundation
import UIKit

protocol MainVCInput: AnyObject {
    func success(viewModel: MainViewModel, delegate: MainTVManagerDelegate)
    func failure(error: Error)
}


class MainVC: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var presenter: MainVCOutput?
    var tableViewManager: MainTVManagerInput?

    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
        presenter?.viewIsReady()
        tableViewManager?.setup(tableView: tableView)
    }
    

    private func setViews() {
        title = "Avito"
        view.backgroundColor = .white
        tableView.register(EmployeesCell.self, forCellReuseIdentifier: "EmployeesCell")
        tableView.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9607843137, blue: 0.9764705882, alpha: 1)
        view.addSubview(tableView)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

extension MainVC: MainVCInput {
    func openAlert() {
        let alert = UIAlertController(title: "Нет соединения", message: "Повторите запрос в сеть", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Повторить", style: .default, handler: { action in
            self.presenter?.viewIsReady()
        }))
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: { action in
        }))
        present(alert, animated: true)
    }
    
    func success(viewModel: MainViewModel, delegate: MainTVManagerDelegate) {
        tableViewManager?.update(with: viewModel)
    }
    
    func failure(error: Error) {
        openAlert()
    }
    
    
}

