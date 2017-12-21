//
//  PaymentViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 12/21/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class PaymentViewController: BaseViewController {

    @IBOutlet weak var webViewPayment: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        payment()
    }

    func payment() {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        let dateTime = dateFormatter.string(from: date)
        
        let refNum = UInt64(NSDate().timeIntervalSince1970 * 1000)
        
        let uuid = UUID().uuidString
        
        let postParam = [
            "access_key": "8fe472d1b77c3fd1869d18c13b03abe3",
            "profile_id": "F3FABD80-AA7D-479B-901E-97531B262188",
            "transaction_uuid": "\(uuid)",
            "signed_field_names": "access_key,profile_id,transaction_uuid,signed_field_names,unsigned_field_names,signed_date_time,locale,transaction_type,reference_number,amount,currency",
            "unsigned_field_names": "",
            "signed_date_time": "\(dateTime)Z",
            "locale": "en",
            "transaction_type": "authorization",
            "reference_number": "\(refNum)",
            "amount": "100.00",
            "currency": "USD"
            
        ]
        
        let dataSgined = buildDataForSign(data: postParam)
        print("data signed: " + dataSgined)
        redirectToPaymentPage(dataSigned: dataSgined, postParam: postParam)
    }
    
    func redirectToPaymentPage(dataSigned: String, postParam: Dictionary<String, String>) {
        RestDataManager.shareInstance.redirectToPaymentPage(urlForHome, action: "encrypte", dataForSigning: dataSigned, completionHanler: {response in
            let postString = self.buildPostPrams(data: postParam) + "&signature=\(response)"
            print("postString:" + postString)
            var request = URLRequest(url: URL(string: urlRedirectToPayment)!)
            request.httpMethod = "POST"
            request.httpBody = postString.data(using: .utf8)
            self.webViewPayment.loadRequest(request)
        })
    }
    
    func buildPostPrams(data: Dictionary<String, String>) -> String {
        var dataToSign: [String] = []
        for (key,value) in data {
            dataToSign.append(key + "=" + value)
        }
        return urlPostSeparate(dataToSign: dataToSign)
        
    }
    func urlPostSeparate(dataToSign: [String]) -> String {
        return dataToSign.joined(separator: "&")
    }
    
    
    func buildDataForSign(data: Dictionary<String, String>) -> String {
        
        let signedFieldNames = data["signed_field_names"]?.split(separator: ",")
        var dataToSign: [String] = []
        var count = 0;
        if let signedFieldNames = signedFieldNames{
            count = signedFieldNames.count
        }
        for  i in 0..<count {
            let value = data[""+signedFieldNames![i]]
            dataToSign.append(signedFieldNames![i] + "=" + value!)
        }
        
        return commaSeparate(dataToSign: dataToSign)
    }
    func commaSeparate(dataToSign: [String]) -> String {
        return dataToSign.joined(separator: ",")
    }
    
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
