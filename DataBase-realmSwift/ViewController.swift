//
//  ViewController.swift
//  DataBase-realmSwift
//
//  Created by Zijia Zhai on 6/13/19.
//  Copyright © 2019 BMLF. All rights reserved.
//

import UIKit
import RealmSwift

class ReamData: Object {
    @objc dynamic var id : Int = 0
    @objc dynamic var uuid = ""
    @objc dynamic var category = ""
    @objc dynamic var fulladdress = ""
    @objc dynamic var address = ""
    @objc dynamic var city = ""
    @objc dynamic var state = ""
    @objc dynamic var zipcode = ""
    @objc dynamic var submittime = ""
    @objc dynamic var longitude = ""
    @objc dynamic var latitude = ""
    @objc dynamic var price = 0
    @objc dynamic var housetype = ""
    @objc dynamic var roomtype = ""
    @objc dynamic var bathroom = ""
    @objc dynamic var parkinglot = ""
    @objc dynamic var washingmachine = ""
    override class func primaryKey() -> String? {
        return "id"
    }
}

class ViewController: UITableViewController {
    var aptViewModel = ZJAptViewModel()
    
    var result: Results<ReamData>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aptViewModel.loadApt { (_) in
            try! uiRealm.write {
                for (index, data) in self.aptViewModel.aptProperties.enumerated() {
                    let reamData = ReamData()
                    reamData.bathroom = data.base!.bathroom!
                    reamData.price = Int(data.base!.price!)!
                    reamData.housetype = data.base!.housetype!
                    reamData.roomtype = data.base!.roomtype!
                    reamData.parkinglot = data.base!.parkinglot!
                    reamData.id = index
                    uiRealm.add(reamData, update: true)
                }
                self.result = uiRealm.objects(ReamData.self).sorted(byKeyPath: "price")
                self.tableView.reloadData()
            }
            
        }
        
    }


}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! UITableViewCell
        cell.textLabel?.text = String(result![indexPath.item].price)
        return cell
    }
}

