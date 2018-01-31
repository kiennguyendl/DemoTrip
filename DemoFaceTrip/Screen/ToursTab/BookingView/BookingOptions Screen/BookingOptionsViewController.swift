//
//  BookingOptionsViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 12/9/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class BookingOptionsViewController: BaseViewController {

    @IBOutlet weak var priceAdult: UILabel!
    @IBOutlet weak var numAdult: UILabel!
    @IBOutlet weak var decreaseAdultBtn: UIButton!
    @IBOutlet weak var increaseAdultBtn: UIButton!
    
    @IBOutlet weak var priceChild: UILabel!
    @IBOutlet weak var numChild: UILabel!
    @IBOutlet weak var decreaseChild: UIButton!
    @IBOutlet weak var increaseChild: UIButton!
    
    @IBOutlet weak var numSenior: UILabel!
    @IBOutlet weak var priceSenior: UILabel!
    @IBOutlet weak var decreaseSenior: UIButton!
    @IBOutlet weak var increaseSenior: UIButton!
    

    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    
    var totalPerson = 0
    var totalAdult = 0
    var totalChild = 0
    var totalSenior = 0
    
    let moneyAdult = 60
    let moneyChild = 50
    let moneySenior = 30
    var totalMoney = 0
    
    var nameCity: String!
    var nameTour: String!
    var statusTour: String!
    var daySelectedInfo: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBackButton()
        self.navigationController?.navigationItem.title = "Booking Options"
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Booking Options"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    func setupLayout() {
        
        bookNowBtn.layer.cornerRadius = bookNowBtn.frame.width / 30
        bookNowBtn.layer.shadowColor = UIColor.gray.cgColor
        bookNowBtn.layer.shadowOffset = CGSize(width: 0.0,height: 5.0)
        bookNowBtn.layer.shadowOpacity = 0.3
        bookNowBtn.layer.shadowRadius = 1.0
        bookNowBtn.layer.masksToBounds = false
        bookNowBtn.layer.cornerRadius = 4.0
        bookNowBtn.backgroundColor = colorBtn
        
        decreaseAdultBtn.layer.cornerRadius = 2
        decreaseAdultBtn.layer.borderWidth = 0.5
        decreaseAdultBtn.layer.borderColor = UIColor.gray.cgColor
        decreaseAdultBtn.tintColor = color3
        
        increaseAdultBtn.layer.cornerRadius = 2
        increaseAdultBtn.layer.borderWidth = 0.5
        increaseAdultBtn.layer.borderColor = UIColor.gray.cgColor
        increaseAdultBtn.tintColor = color3
        
        decreaseChild.layer.cornerRadius = 2
        decreaseChild.layer.borderWidth = 0.5
        decreaseChild.layer.borderColor = UIColor.gray.cgColor
        decreaseChild.tintColor = color3
        
        increaseChild.layer.cornerRadius = 2
        increaseChild.layer.borderWidth = 0.5
        increaseChild.layer.borderColor = UIColor.gray.cgColor
        increaseChild.tintColor = color3
        
        decreaseSenior.layer.cornerRadius = 2
        decreaseSenior.layer.borderWidth = 0.5
        decreaseSenior.layer.borderColor = UIColor.gray.cgColor
        decreaseSenior.tintColor = color3
        
        increaseSenior.layer.cornerRadius = 2
        increaseSenior.layer.borderWidth = 0.5
        increaseSenior.layer.borderColor = UIColor.gray.cgColor
        increaseSenior.tintColor = color3
        
        numAdult.text = "\(totalAdult)"
        numChild.text = "\(totalChild)"
        numSenior.text = "\(totalSenior)"
        
        
        totalPrice.text = "$\(totalMoney)"
    }

    @IBAction func decreaseAdult(_ sender: Any) {
        if totalAdult != 0{
            totalAdult -= 1
            numAdult.text = "\(totalAdult)"
            totalMoney -= moneyAdult
            totalPrice.text = "$\(totalMoney)"
        }
    }
    @IBAction func increaseAdult(_ sender: Any) {
        if totalAdult < 10{
            totalAdult += 1
            numAdult.text = "\(totalAdult)"
            totalMoney += moneyAdult
            totalPrice.text = "$\(totalMoney)"
        }
    }
    
    @IBAction func decreaseChild(_ sender: Any) {
        if totalChild != 0{
            totalChild -= 1
            numChild.text = "\(totalChild)"
            totalMoney -= moneyChild
            totalPrice.text = "$\(totalMoney)"
        }
    }
    @IBAction func increaseChild(_ sender: Any) {
        if totalChild < 10{
            totalChild += 1
            numChild.text = "\(totalChild)"
            totalMoney += moneyChild
            totalPrice.text = "$\(totalMoney)"
        }
    }
    
    @IBAction func decreaseSenior(_ sender: Any) {
        if totalSenior != 0{
            totalSenior -= 1
            numSenior.text = "\(totalSenior)"
            totalMoney -= moneySenior
            totalPrice.text = "$\(totalMoney)"
        }
    }
    @IBAction func increaseSenior(_ sender: Any) {
        if totalSenior < 10{
            totalSenior += 1
            numSenior.text = "\(totalSenior)"
            totalMoney += moneySenior
            totalPrice.text = "$\(totalMoney)"
        }
    }
    

    @IBAction func bookNow(_ sender: Any) {
        let totalPerson = totalAdult + totalChild + totalSenior
        if totalPerson > 0{
            let vc = DetailBookingViewController()
            vc.nameCity = nameCity
            vc.nameTour = nameTour
            vc.statusTour = statusTour
            vc.daySelectedInfo = daySelectedInfo
            vc.numAdult = totalAdult
            vc.numChild = totalChild
            vc.numInfant = totalSenior
            navigationController?.pushViewController(vc, animated: true)
        }else{
            let alert = UIAlertController(title: "Message", message: "Please select number person!", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}
