//
//  MainDataConverter.swift
//  AvitoTest
//
//  Created by Abduladzhi on 29.10.2022.
//

import Foundation

protocol MainDataConverterInput {
    func convert(data: MainModel, delegate: AnyObject?) -> MainViewModel
}

final class MainDataConverter { }

extension MainDataConverter: MainDataConverterInput {
    private typealias Row = MainViewModel.Row
    private typealias EmployeesConfigurator = TableCellConfigurator<EmployeesCell, EmployeesCell.Model>
    
    func convert(data: MainModel, delegate: AnyObject?) -> MainViewModel {
        var rows: [Row] = []
        let names = data.company.employees.sorted(by: {$0.name < $1.name})
        names.forEach { item in
            var employeesRow: Row
            let employeesModel = EmployeesCell.Model(delegate: delegate as! MainTVManagerDelegate, item: item)
            let employeesConfigurator = EmployeesConfigurator(item: employeesModel)
            employeesRow = Row(configurator: employeesConfigurator)
            rows.append(employeesRow)
        }
        return MainViewModel(rows: rows)
    }
}
