//
//  CalendarCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/28/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

//protocol calendarProtocol {
//    func pushToBookingView(vc: UIViewController)
//}

class CalendarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var monthCollectionView: UICollectionView!
    
    var selectedIndexPaths    = [IndexPath]()
    var monthInfo: (firstDay:Int, daysTotal:Int)!
    var index: Int!
    var todayIndex: IndexPath!
    var month: Int!
    var year: Int!
    
    //var delegar: calendarProtocol?
    var listBookingDayOfMonth: [TimeBooking]?{
        didSet{
            monthCollectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        monthCollectionView.delegate = self
        monthCollectionView.dataSource = self
        monthCollectionView.register(UINib.init(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DayCell")
        // Initialization code
        
        if let layout = monthCollectionView.collectionViewLayout as? CalendarFlowLayout{
            layout.scrollDirection = .horizontal
            layout.itemSize = cellSize(in: self.bounds)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
//        self.isUserInteractionEnabled = false
    }
    
    private func cellSize(in bounds: CGRect) -> CGSize {
        return CGSize(
            width:   monthCollectionView.frame.size.width / CGFloat(8 * 2),
            height: monthCollectionView.frame.size.width / CGFloat(8 * 2)
            /*(monthCollectionView.frame.size.height) / CGFloat(MAXIMUM_NUMBER_OF_ROWS * 2)*/
        )
    }
    
    deinit {
        //removeObserverForDetail()
    }
    
}

extension CalendarCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DateCollectionViewCell
        
        let firstDayIndex = monthInfo.firstDay
        let numberOfDaysTotal = monthInfo.daysTotal
        
        
        let fromStartOfMonthIndexPath = IndexPath(item: indexPath.item - firstDayIndex, section: indexPath.section)
        let lastDayIndex = firstDayIndex + numberOfDaysTotal
    
        let date = Date()
        let calendar = Calendar.current
        
        let month = calendar.component(.month, from: date)
        
        if (firstDayIndex..<lastDayIndex).contains(indexPath.item) {
            
            cell.dateLbl.text = String(fromStartOfMonthIndexPath.item + 1)
            
            /*set color for day
             if day <= current day -> gray color
             else -> black color
             */
            let idx = todayIndex!
            if (indexPath.item <= idx.item + firstDayIndex) && ((month - 1) == self.month){
                cell.dateLbl.textColor = UIColor.gray
            }else{
                /*
                 render day booking
                 */
                
                for daybooking in self.listBookingDayOfMonth!{
                    let dayBook = daybooking.day
                    let monthBook = daybooking.month
                    let yearBook = daybooking.year
                    
                    if dayBook! == (fromStartOfMonthIndexPath.item + 1) && (monthBook! - 1) == self.month! && yearBook == self.year!{
                        //cell.dateLbl.textColor = UIColor.blue
                        DispatchQueue.main.async {
                            cell.borderView.layer.cornerRadius = cell.borderView.frame.width / 2
                            cell.borderView.layer.borderWidth = 1
                            cell.borderView.layer.borderColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1).cgColor
                            cell.dateLbl.textColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1)
                            cell.borderView.layer.masksToBounds = true
                        }
                        
                    }else{
                        cell.dateLbl.textColor = UIColor.black
                    }
                }
                
            }
            
            
        }else{
            cell.dateLbl.text = ""
            
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.width / 7 - 1
        //let height = self.frame.height / 6 - 1
        return CGSize(width: width, height: width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = BookingTourViewController()
//        delegar?.pushToBookingView(vc: vc)
        let data = [
            "section": index,
            "data": listBookingDayOfMonth
            ] as [String : Any]
        NotificationCenter.default.post(name: calendarPushtoBookingNotification, object: data)
    }
    
}
