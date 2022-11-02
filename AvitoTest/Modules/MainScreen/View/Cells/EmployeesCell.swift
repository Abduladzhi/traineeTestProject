//
//  EmployeesCell.swift
//  AvitoTest
//
//  Created by Abduladzhi on 03.11.2022.
//

import UIKit

class EmployeesCell: UITableViewCell {

    var arraySkills = ""

    let nameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let skillsLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension EmployeesCell: Configurable {
    
    struct Model {
        var delegate: MainTVManagerDelegate
        var item: Employees
    }
    
    func configure(with model: Model) {
        model.item.skills.forEach { skill in
            arraySkills += "\(skill), "
        }
        
        let trimmedstr = arraySkills.trimmingCharacters(in: .whitespacesAndNewlines)
        if let lastchar = trimmedstr.last {
            if [","].contains(lastchar) {
                arraySkills = String(trimmedstr.dropLast())
            }
        }

        nameLabel.text = "Name: \(model.item.name)"
        phoneLabel.text = "Phone: \(model.item.phone_number)"
        skillsLabel.text = "Skills: \(arraySkills)"
        setView()
        setConstraints()
    }
    
    private func setView() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneLabel)
        contentView.addSubview(skillsLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            
            phoneLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            phoneLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            
            skillsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            skillsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            skillsLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 4),
            skillsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }
    
}
