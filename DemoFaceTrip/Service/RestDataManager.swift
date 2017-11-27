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
    
    //get list city from server
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
    
    //search city
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
    
    //get data for tableview cell at home screen
    func restDataFollowTypeOfMenu<T: Mappable>(_ url: String, menu: String, action: String, id: Int, idMenu: Int, type: String, complertionHandler: @escaping(T?, NSError?)->Void){
        
        let data = [
            "menu": menu,
            "action" : action,
            "id": id,
            "idMenu": idMenu,
            "type": type
            ] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: data, headers: nil).validate().responseJSON(completionHandler: {response in
            
            switch response.result{
            case .success(let data):
                var result: T?
                if let data = data as? [String: AnyObject] {
                    
                        let itemMapper = Mapper<T>()
                        if let item = itemMapper.map(JSONObject: data){
                            result = item
                        }
                    
                }
                
                if result != nil{
                    complertionHandler(result, nil)
                }else{
                    complertionHandler(nil, NSError(domain: "abc", code: 123, userInfo: nil))
                }
            case .failure(let error):
                complertionHandler(nil, error as NSError)
            }
        })
    }
    
    //get data for listing screen
    func restDataForListingScrenFollowTypeOfMenu<T: Mappable>(_ url: String, menu: String, action: String, idCity: Int, type: String, typeSubMenu: String, complertionHandler: @escaping(T?, NSError?)->Void){
        
        let data = [
            "menu": menu,
            "action" : action,
            "idCity": idCity,
            "typeMenu": type,
            "typeSubMenu": typeSubMenu
            ] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: data, headers: nil).validate().responseJSON(completionHandler: {response in
            
            switch response.result{
            case .success(let data):
                var result: T?
                if let data = data as? [String: AnyObject] {
                    
                    let itemMapper = Mapper<T>()
                    if let item = itemMapper.map(JSONObject: data){
                        result = item
                    }
                    
                }
                
                if result != nil{
                    complertionHandler(result, nil)
                }else{
                    complertionHandler(nil, NSError(domain: "abc", code: 123, userInfo: nil))
                }
            case .failure(let error):
                complertionHandler(nil, error as NSError)
            }
        })
    }
    
    //get categories for header zero in the home screen
    func restDataForHeaderZero<T: Mappable>(_ url: String, idCity: Int, type: String, completionHandler: @escaping([T]?, NSError?)->Void) {
        let data = [
            "idCity": idCity,
            "type": type
            ] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: data, headers: nil).validate().responseJSON(completionHandler: {response in
            
            switch response.result{
            case .success(let data):
                var result = [T]()
                if let data = data as?[AnyObject]{
                    for index in data{
                        let itemMapper = Mapper<T>()
                        if let item = itemMapper.map(JSONObject: index){
                            result.append(item)
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
}
