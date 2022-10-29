//
//  MainModel.swift
//  AvitoTest
//
//  Created by Abduladzhi on 29.10.2022.
//

import Foundation

struct MainModel: Codable {
    var company: Company
}

struct Company: Codable {
    var name: String
    var employees: [Employees]
}

struct Employees: Codable {
    var name: String
    var phone_number: String
    var skills: [String]
}
