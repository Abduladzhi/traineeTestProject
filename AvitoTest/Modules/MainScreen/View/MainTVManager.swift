//
//  MainTVManager.swift
//  AvitoTest
//
//  Created by Abduladzhi on 29.10.2022.
//

import Foundation
import UIKit

protocol MainTVManagerInput {
    func setup(tableView: UITableView)
    func update(with viewModel: MainViewModel)
}

protocol MainTVManagerDelegate: AnyObject {
//    func addChildren()
//    func deleteChild(uuid: UUID)
//    func updateChild(child: Childs)
//    func updateFather(father: MainModel)
//    func clearChild()
}


final class MainTVManager: NSObject{
    
    weak var delegate: MainTVManagerDelegate?
    private weak var tableView: UITableView?
    private var viewModel: MainViewModel?
}

extension MainTVManager: MainTVManagerInput {
    
    func setup(tableView: UITableView) {
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView = tableView
    }
    
    func update(with viewModel: MainViewModel) {
        self.viewModel = viewModel
        tableView?.reloadData()
    }
}

extension MainTVManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = viewModel?.rows[safe: indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseId, for: indexPath)
        row.configurator.configure(cell: cell)
        cell.selectionStyle = .none
        return cell
    }
    
}

extension MainTVManager: UITableViewDelegate {
    
}
