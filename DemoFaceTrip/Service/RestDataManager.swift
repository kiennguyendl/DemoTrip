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
                completionHandler(nil, error as? NSError)
            }
        })
    }
}
