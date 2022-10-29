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
//    func openAlert()
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
        title = ""
        view.backgroundColor = .white
//        tableView.register(UINib(nibName: "ChildrenCell", bundle: nil), forCellReuseIdentifier: "ChildrenCell")
//        tableView.register(UINib(nibName: "HeaderChildrenCell", bundle: nil), forCellReuseIdentifier: "HeaderChildrenCell")
//        tableView.register(UINib(nibName: "FatherCell", bundle: nil), forCellReuseIdentifier: "FatherCell")
//        tableView.register(UINib(nibName: "HeaderFatherCell", bundle: nil), forCellReuseIdentifier: "HeaderFatherCell")
//        tableView.register(UINib(nibName: "DeleteCell", bundle: nil), forCellReuseIdentifier: "DeleteCell")
        
        tableView.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9607843137, blue: 0.9764705882, alpha: 1)
        tableView.separatorColor = .clear
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
//    func openAlert() {
//        let alert = UIAlertController(title: "Вы точно хотите сбросить данные?", message: "Сброс данных приведёт к удалению всех записей", preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title: "Cбросить данные", style: .default, handler: { action in
//            self.presenter?.deleteData()
//        }))
//        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: { action in
//        }))
//        present(alert, animated: true)
//    }
    
    func success(viewModel: MainViewModel, delegate: MainTVManagerDelegate) {
        tableViewManager?.update(with: viewModel)
    }
    
    func failure(error: Error) {
        
    }
    
    
}

