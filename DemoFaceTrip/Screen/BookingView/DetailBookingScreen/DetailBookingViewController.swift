//
//  DetailBookingViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 12/11/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class DetailBookingViewController: BaseViewController {

    @IBOutlet weak var nextBtn: UIButton!
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
        nextBtn.layer.shadowOpacity = 0.7
        nextBtn.layer.shadowRadius = 1.0
        nextBtn.layer.masksToBounds = false
        nextBtn.layer.cornerRadius = 4.0
        nextBtn.backgroundColor = color3
    }
    @IBAction func nextStepBtn(_ sender: Any) {
        let vc = BookingPaymentViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
