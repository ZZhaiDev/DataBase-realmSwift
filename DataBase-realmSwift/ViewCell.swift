//
//  CollectionViewCell.swift
//  DataBase-realmSwift
//
//  Created by zijia on 6/23/19.
//  Copyright © 2019 BMLF. All rights reserved.
//

import UIKit
import RealmSwift

class ViewCell: UITableViewCell {
    
    let price = UILabel(frame: .zero)
    let id = UILabel(frame: .zero)
    let bathroom = UILabel(frame: .zero)
    let housetype = UILabel(frame: .zero)
    let parkinglot = UILabel(frame: .zero)
    
    var data: ReamData? {
        didSet {
            guard let data = data else { return }
            price.text = String(data.price)
            id.text = String(data.id)
            bathroom.text = data.bathroom
            housetype.text = data.housetype
            parkinglot.text = data.parkinglot
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "cellId")
        let stackV = UIStackView(arrangedSubviews: [id, price, bathroom, housetype, parkinglot])
        stackV.axis = .horizontal
        stackV.distribution = .fillEqually
        stackV.spacing = 10
        stackV.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackV)
        stackV.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackV.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        stackV.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        stackV.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

