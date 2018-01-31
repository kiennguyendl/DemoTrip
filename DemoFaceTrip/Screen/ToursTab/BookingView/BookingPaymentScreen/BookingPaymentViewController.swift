//
//  BookingPaymentViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 12/11/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class BookingPaymentViewController: BaseViewController {

    @IBOutlet weak var inforTour: UILabel!
    @IBOutlet weak var dayInfo: UILabel!
    @IBOutlet weak var statusOfTour: UILabel!
    @IBOutlet weak var infoOfNumPerson: UILabel!
    
    
    @IBOutlet weak var confirmPaymentBtn: UIButton!
    
    var nameCity: String!
    var nameTour: String!
    var statusTour: String!
    var daySelectedInfo: String!
    var numAdult = 0
    var numChild = 0
    var numInfant = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initBackButton()
        self.navigationController?.navigationItem.title = "Booking"
        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Booking"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    func setupLayout() {
        confirmPaymentBtn.layer.cornerRadius = confirmPaymentBtn.frame.width / 30
        confirmPaymentBtn.layer.shadowColor = UIColor.gray.cgColor
        confirmPaymentBtn.layer.shadowOffset = CGSize(width: 0.0,height: 5.0)
        confirmPaymentBtn.layer.shadowOpacity = 0.3
        confirmPaymentBtn.layer.shadowRadius = 1.0
        confirmPaymentBtn.layer.masksToBounds = false
        confirmPaymentBtn.layer.cornerRadius = 4.0
        confirmPaymentBtn.backgroundColor = colorBtn
        
        if let nameCity = nameCity, let nameTour = nameTour, let status = statusTour, let dayInfo = daySelectedInfo{
            self.inforTour.text = "\(nameCity): \(nameTour)"
            self.dayInfo.text = dayInfo
            self.statusOfTour.text = status
            self.infoOfNumPerson.text = "\(numAdult) x Adult, \(numChild) x Children, \(numInfant) x Infant"
        }
        
        
    }
    
    
    @IBAction func confirmPayment(_ sender: Any) {
        let vc = PaymentViewController()
//        present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
