//
//  ZJAptViewModel.swift
//  BMLF
//
//  Created by Zijia Zhai on 5/31/19.
//  Copyright © 2019 BMLF. All rights reserved.
//

import UIKit
import Alamofire

let baseAPI = "http://api.qubeimei.com/"

class ZJAptViewModel {
    lazy var aptModel: ZJAddAptModel = ZJAddAptModel()
    lazy var aptProperties: [AddAptProperties] = [AddAptProperties]()
    static let pageSize = 300
}

extension ZJAptViewModel {
    func loadApt(page: Int = 1, pageSize: Int = ZJAptViewModel.pageSize, city: String = "", finished: @escaping ([String: Any]) -> Void) {
        let api = "\(baseAPI)api/v1/rental/house/?page=\(page)&page_size=\(pageSize)&city=\(city)"
        NetworkTools.requestData(.get, URLString: api) { (responce) in
            self.aptProperties.removeAll()
            guard let dict = responce as? [String: Any] else { return }
            guard let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
                return
            }
            do {
                let data = try JSONDecoder().decode(ZJAddAptModel.self, from: jsonData)
                self.aptModel = data
                guard let results = data.results else {return}
                guard let features = results.features else {return}
                for feature in features {
                    guard let properties = feature.properties else {return}
                    self.aptProperties.append(properties)
                }
            } catch let jsonError {
            }
            finished(responce as! [String : Any])
        }
    }
}



enum MethodType {
    case get
    case post
}

class NetworkTools {
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any?) -> Void) {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        AF.request(URLString, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.value ?? "")
                finishedCallback(response)
                return
            }
            finishedCallback(result)
        }
        
    }
}
