//
//  DetailBookingViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 12/11/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class DetailBookingViewController: BaseViewController {

    @IBOutlet weak var inforTour: UILabel!
    @IBOutlet weak var dayInfo: UILabel!
    @IBOutlet weak var statusOfTour: UILabel!
    @IBOutlet weak var infoOfNumPerson: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfEmailAddress: UITextField!
    @IBOutlet weak var tfPickUpLocation: UITextField!
    
    @IBOutlet weak var lineViewFullName: UIView!
    @IBOutlet weak var lineViewPhoneNumber: UIView!
    @IBOutlet weak var lineViewEmailAddress: UIView!
    @IBOutlet weak var lineViewPickupLocation: UIView!
    
    @IBOutlet weak var lblWarningName: UILabel!
    @IBOutlet weak var lblWarningPhoneNumber: UILabel!
    
    @IBOutlet weak var lblWarningEmail: UILabel!
    @IBOutlet weak var lblWarningPickupLocation: UILabel!
    
    var nameCity: String!
    var nameTour: String!
    var statusTour: String!
    var daySelectedInfo: String!
    var numAdult = 0
    var numChild = 0
    var numInfant = 0
    
    var colorView = UIColor(red: 32.0/255.0, green: 88.0/255.0, blue: 7.0/255.0, alpha: 1)
    
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
        nextBtn.layer.cornerRadius = nextBtn.frame.width / 30
        nextBtn.layer.shadowColor = UIColor.gray.cgColor
        nextBtn.layer.shadowOffset = CGSize(width: 0.0,height: 5.0)
        nextBtn.layer.shadowOpacity = 0.3
        nextBtn.layer.shadowRadius = 1.0
        nextBtn.layer.masksToBounds = false
        nextBtn.layer.cornerRadius = 4.0
        nextBtn.backgroundColor = colorBtn
        
        if let nameCity = nameCity, let nameTour = nameTour, let status = statusTour, let dayInfo = daySelectedInfo{
            self.inforTour.text = "\(nameCity): \(nameTour)"
            self.dayInfo.text = dayInfo
            self.statusOfTour.text = status
            self.infoOfNumPerson.text = "\(numAdult) x Adult, \(numChild) x Children, \(numInfant) x Infant"
        }
        
        tfFullName.becomeFirstResponder()
        tfPhoneNumber.keyboardType = .numberPad
        tfEmailAddress.keyboardType = .emailAddress
        
        tfFullName.delegate = self
        tfPhoneNumber.delegate = self
        tfEmailAddress.delegate = self
        tfPickUpLocation.delegate = self
    }
    @IBAction func nextStepBtn(_ sender: Any) {
        
        if tfFullName.text == ""{
            lineViewFullName.backgroundColor = .red
            lblWarningName.isHidden = false
        }
        
        if tfPhoneNumber.text == ""{
            lineViewPhoneNumber.backgroundColor = .red
            lblWarningPhoneNumber.isHidden = false
        }
        if tfEmailAddress.text == ""{
            lineViewEmailAddress.backgroundColor = .red
            lblWarningEmail.isHidden = false
        }
        if tfPickUpLocation.text == ""{
            lineViewPickupLocation.backgroundColor = .red
            lblWarningPickupLocation.isHidden = false
        }
        
        if tfFullName.text != "" && tfPhoneNumber.text != "" && tfEmailAddress.text != "" && tfPickUpLocation.text != ""{
            let vc = BookingPaymentViewController()
            vc.nameCity = nameCity
            vc.nameTour = nameTour
            vc.statusTour = statusTour
            vc.daySelectedInfo = daySelectedInfo
            vc.numAdult = numAdult
            vc.numChild = numChild
            vc.numInfant = numInfant
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension DetailBookingViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == tfFullName{
            lineViewFullName.backgroundColor = colorView
            lblWarningName.isHidden = true
        }
        
        if textField == tfPhoneNumber{
            lineViewPhoneNumber.backgroundColor = colorView
            lblWarningPhoneNumber.isHidden = true
        }
        if textField == tfEmailAddress{
            lineViewEmailAddress.backgroundColor = colorView
            lblWarningEmail.isHidden = true
        }
        if textField == tfPickUpLocation{
            lineViewPickupLocation.backgroundColor = colorView
            lblWarningPickupLocation.isHidden = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfFullName && tfFullName.text == ""{
            lineViewFullName.backgroundColor = .red
            lblWarningName.isHidden = false
        }
        
        if textField == tfPhoneNumber && tfPhoneNumber.text == ""{
            lineViewPhoneNumber.backgroundColor = .red
            lblWarningPhoneNumber.isHidden = false
        }
        if textField == tfEmailAddress && tfEmailAddress.text == ""{
            lineViewEmailAddress.backgroundColor = .red
            lblWarningEmail.isHidden = false
        }
        if textField == tfPickUpLocation && tfPickUpLocation.text == ""{
            lineViewPickupLocation.backgroundColor = .red
            lblWarningPickupLocation.isHidden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
