//
//  RestDataManager.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/6/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class RestDataManager: NSObject {
    static let shareInstance = RestDataManager()
    
    func restDataForHome<T: Mappable>(_ url: String, completionHandler: @escaping([T]?, NSError?) -> Void) {
        
        Alamofire.request(url, method: .get, headers: nil).validate().responseJSON(completionHandler: { response in
            switch response.result{

            case .success(let data):
                var result = [T]()
                if let data = data as? Dictionary<String, AnyObject>{
                    //print(data)
                    if let catagory = data["catagory"] as? [ AnyObject]{
                        for item in catagory{
                            let itemMapper = Mapper<T>()
                            let item = itemMapper.map(JSONObject: item)
                            result.append(item!)
                        }
                        
                    }
                }
                
                if result.count > 0{
                    completionHandler(result, nil)
                }else{
                    completionHandler(nil, NSError(domain: "abc", code: 123, userInfo: nil))
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
        })
    }
    
    func restDataForChooseCity<T: Mappable>(_ url: String, type: String, completionHandler: @escaping([T]?, NSError?) -> Void){
        let data = [
            "type": type
        ]
        
        Alamofire.request(url, method: .post, parameters: data, headers: nil).validate().responseJSON(completionHandler: { response in
            
            switch response.result{
                
            case .success(let data):
                var result = [T]()
                if let cities = data as? [AnyObject]{
                        for city in cities{
                            let itemMapper = Mapper<T>()
                            let item = itemMapper.map(JSONObject: city)
                            result.append(item!)
                        }
                }
                if result.count > 0{
                    completionHandler(result, nil)
                }else{
                    completionHandler(nil, NSError(domain: "abc", code: 123, userInfo: nil))
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            })
    }
    
    func searchCityFollowText<T: Mappable>(_ url: String, action: String, keyword: String, completionHandler: @escaping([T]?, NSError?)-> Void) {
        
        let data = [
            "action": action,
            "keyword": keyword
        ]
        Alamofire.request(url, method: .post, parameters: data, headers: nil).validate().responseJSON(completionHandler: { response in
            
            switch response.result{
                
            case .success(let data):
                var result = [T]()
                if let items = data as? [AnyObject]{
                    for item in items{
                        let itemMapper = Mapper<T>()
                        let item = itemMapper.map(JSONObject: item)
                        result.append(item!)
                    }
                }
                
                if result.count > 0{
                    completionHandler(result, nil)
                }else{
                    completionHandler(nil, NSError(domain: "abc", code: 123, userInfo: nil))
                }
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            
        })
    }
    
    func restDataFollowCity<T: Mappable>(_ url: String, action: String, keyword: String, completionHandler: @escaping([T]?, NSError?)-> Void) {
        let data = [
            "action": action,
            "keyword": keyword
        ]
        
        Alamofire.request(url, method: .post, parameters: data, headers: nil).validate().responseJSON(completionHandler: {response in
            
            switch response.result{
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        })
    }
}
