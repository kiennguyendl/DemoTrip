//
//  ChooseCityViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/10/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

protocol ChooseCityProtocol {
    func loadDataForHome()
}

class ChooseCityViewController: UIViewController {
    @IBOutlet weak var citySearch: UITextField!
    @IBOutlet weak var tableViewCities: UITableView!
    
    @IBOutlet weak var clearBtn: UIButton!
    var locationManager = CLLocationManager()
    var cities: [City] = []
    var filterData: [City] = []
    var delegate: ChooseCityProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearBtn.isHidden = true
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        tableViewCities.dataSource = self
        tableViewCities.delegate = self
        tableViewCities.register(UINib.init(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "CityCell")
        
        restDataCity()
        
        citySearch.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }

    @objc func textFieldDidChange(textField: UITextField) {
        DispatchQueue.main.async {
            self.clearBtn.isHidden = false
        }
        
        filterData = (textField.text?.isEmpty)! ? cities: cities.filter({(city: City) -> Bool in
            return city.name?.range(of: textField.text!, options: .caseInsensitive) != nil
        })
        tableViewCities.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearTextInTextField(_ sender: Any) {
        citySearch.text = ""
        filterData = cities
        clearBtn.isHidden = true
        tableViewCities.reloadData()
    }
    
    
    private func getCurrentCity(){
        let location = locationManager.location
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location!, completionHandler: { (placemarksArray, error) in
            if let placemarkArray = placemarksArray{
                let placeMark = placemarkArray.last
                let city = placeMark?.addressDictionary!["City"] as! String
                Settings.cityPicked = city
                self.delegate?.loadDataForHome()
                self.dismiss(animated: true, completion: nil)
                //self.tableViewCities.reloadData()
            }
        })
    }
 
    func restDataCity() {
        RestDataManager.shareInstance.restDataForChooseCity(urlForHome, type: "Cities", completionHandler: {[weak self] (cities: [City]?, error: NSError?) in
            guard let strongSelf = self else{return}
            if error == nil{
                if let cities = cities{
                    strongSelf.cities = cities
                    strongSelf.filterData = strongSelf.cities
                    strongSelf.tableViewCities.reloadData()
                }
            }else{
                print("false parse")
            }
        })
    }
}

extension ChooseCityViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityTableViewCell
        let currentRow = indexPath.row
        if currentRow == 0{
            cell.cityName.text = filterData[currentRow].name
        }else{
            cell.cityName.text = filterData[currentRow].name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentRow = indexPath.row
        if currentRow == 0{
            self.getCurrentCity()
            
        }else{
            let city = cities[indexPath.row].name! + " City"
            Settings.cityPicked = city
            delegate?.loadDataForHome()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        citySearch.endEditing(true)
    }
}

extension ChooseCityViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("test")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ChooseCityViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let myLocation = locations.last{
//            self.getCurrentCity(location: myLocation)
//        }
        manager.stopUpdatingLocation()
    }
    
}

