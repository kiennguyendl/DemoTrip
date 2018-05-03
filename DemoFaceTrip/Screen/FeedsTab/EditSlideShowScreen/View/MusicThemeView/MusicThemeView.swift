//
//  MusicThemeView.swift
//  
//
//  Created by Kiên Nguyễn on 4/14/18.
//

import Foundation
import UIKit
import AVFoundation

class MusicBackground: NSObject {
    var backgroundImage: UIImage!
    var name: String!
    var typeMusic: String!
    init(backgroundImage: UIImage, name: String, typeMusic: String) {
        self.backgroundImage = backgroundImage
        self.name = name
        self.typeMusic = typeMusic
    }
}

class MusicThemeView: BaseView {
    @IBOutlet weak var listMusicThemeCollectionView: UICollectionView!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var timeRecordLbl: UILabel!
    @IBOutlet weak var heightOfRecordBtn: NSLayoutConstraint!
    
    @IBOutlet weak var cancelRecordBtn: UIButton!
    @IBOutlet weak var saveRecordBtn: UIButton!
    @IBOutlet weak var playOrPauseRecordBtn: UIButton!
    
    @IBOutlet weak var listRecordBtn: UIButton!
    
    @IBOutlet weak var listRecordView: UIView!
    @IBOutlet weak var bottomConstraintRecordView: NSLayoutConstraint!
    
    @IBOutlet weak var listRecordTableView: UITableView!
    
    @IBOutlet weak var viewTop: UIView!
    let listMusicBackground = [MusicBackground(backgroundImage: UIImage(named: "01-1")!,name: "TRAVEL", typeMusic: enspired),
                               MusicBackground(backgroundImage: UIImage(named: "02-1")!,name: "FRIENDS",  typeMusic: birthday),
                               MusicBackground(backgroundImage: UIImage(named: "03-1")!,name: "BIRTHDAY",  typeMusic: playful),
                               MusicBackground(backgroundImage: UIImage(named: "04-1")!,name: "LOVE",  typeMusic: epic),
                               MusicBackground(backgroundImage: UIImage(named: "01-1")!,name: "ALONE",  typeMusic: happy),
                               ]
    
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    var isRecording = false
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var recordFileName = ""
    var listRecord: [String] = []
    var displayTimer: Timer? = nil
    var oldOldRowIndexPathTableView = IndexPath(row: 0, section: 0)
    var isListRecordShowing = false
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupButton()
        setupCancelSaveRecordBtn()
        addSwipeForView()
        //        setupPlayAndShowListRecord()
        addObserver()
        bottomConstraintRecordView.constant = -listRecordView.frame.height
        listRecordView.frame.origin.y += listRecordView.frame.height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        listMusicThemeCollectionView.delegate = self
        listMusicThemeCollectionView.dataSource = self
        listMusicThemeCollectionView.register(UINib.init(nibName: "TypeMusicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TypeMusicCell")
        
        listRecordTableView.delegate = self
        listRecordTableView.dataSource = self
        listRecordTableView.register(UINib.init(nibName: "ListRecordTableViewCell", bundle: nil), forCellReuseIdentifier: "recordCell")
        
        viewTop.layer.cornerRadius = viewTop.frame.height / 2
        
    }
    
    func setupButton() {
        
        let image = UIImage(named: "Record")
//        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        recordBtn.setImage(image, for: .normal)
//        recordBtn.tintColor = UIColor(red: 48/255, green: 125/255, blue: 251/255, alpha: 1)
//        recordBtn.layer.borderWidth = 1
//        recordBtn.layer.cornerRadius = recordBtn.frame.width / 2
//        recordBtn.clipsToBounds = true
//        recordBtn.layer.masksToBounds = true
        
//        recordBtn.layer.borderColor = UIColor(red: 48/255, green: 125/255, blue: 251/255, alpha: 1).cgColor
        
        let imageCancelRecord = #imageLiteral(resourceName: "Delete")
        let tintedImageCancel = imageCancelRecord.withRenderingMode(.alwaysTemplate)
        cancelRecordBtn.setImage(imageCancelRecord, for: .normal)
//        cancelRecordBtn.layer.cornerRadius = cancelRecordBtn.frame.width / 2
//        cancelRecordBtn.clipsToBounds = true
//        cancelRecordBtn.layer.masksToBounds = true
        //        cancelRecordBtn.layer.borderWidth = 1
        //        cancelRecordBtn.layer.borderColor = UIColor.gray.cgColor
        cancelRecordBtn.tintColor = .gray
        
        
        let imageSaveRecord = #imageLiteral(resourceName: "Accept")
        let tintedImageSave = imageSaveRecord.withRenderingMode(.alwaysTemplate)
        saveRecordBtn.setImage(imageSaveRecord, for: .normal)
//        saveRecordBtn.layer.cornerRadius = saveRecordBtn.frame.width / 2
//        saveRecordBtn.clipsToBounds = true
//        saveRecordBtn.layer.masksToBounds = true
        //        saveRecordBtn.layer.borderColor = UIColor(red: 48/255, green: 125/255, blue: 251/255, alpha: 1).cgColor
        //        saveRecordBtn.layer.borderWidth = 1
        saveRecordBtn.tintColor = UIColor(red: 48/255, green: 125/255, blue: 251/255, alpha: 1)
        
        let imagePlay = UIImage(named: "Play-1")?.withRenderingMode(.alwaysTemplate)
        playOrPauseRecordBtn.setImage(imagePlay, for: .normal)
//        playOrPauseRecordBtn.layer.cornerRadius = playOrPauseRecordBtn.frame.width / 2
//        playOrPauseRecordBtn.clipsToBounds = true
//        playOrPauseRecordBtn.layer.masksToBounds = true
//        playOrPauseRecordBtn.tintColor = UIColor(red: 48/255, green: 125/255, blue: 251/255, alpha: 1)
        
        
        let imageListRecord = UIImage(named: "List")?.withRenderingMode(.alwaysTemplate)
        listRecordBtn.setImage(imageListRecord, for: .normal)
//        listRecordBtn.layer.cornerRadius = listRecordBtn.frame.width / 2
//        listRecordBtn.clipsToBounds = true
//        listRecordBtn.layer.masksToBounds = true
//        listRecordBtn.tintColor = UIColor(red: 48/255, green: 125/255, blue: 251/255, alpha: 1)
        
        
        
        
        //        setupCancelSaveRecordBtn()
    }
    
    func setupRecordBtn() {
        if isRecording{
            let image = #imageLiteral(resourceName: "Pause-1")
            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            recordBtn.setImage(image, for: .normal)
//            recordBtn.tintColor = .red
//            recordBtn.layer.borderWidth = 0
        }else{
            let image = UIImage(named: "Record")
//            let tintedImage = image?.withRenderingMode(.alwaysTemplate)
            recordBtn.setImage(image, for: .normal)
//            recordBtn.tintColor = UIColor(red: 48/255, green: 125/255, blue: 251/255, alpha: 1)
//            recordBtn.layer.borderWidth = 1
        }
    }
    
    func setupCancelSaveRecordBtn() {
        
        if isRecording{
            cancelRecordBtn.isHidden = false
            saveRecordBtn.isHidden = false
        }else{
            cancelRecordBtn.isHidden = true
            saveRecordBtn.isHidden = true
        }
    }
    
    func setupPlayAndShowListRecord() {
        
        if isRecording{
            playOrPauseRecordBtn.isHidden = true
            listRecordBtn.isHidden = true
        }else{
            if listRecord.count > 0{
                playOrPauseRecordBtn.isHidden = false
                listRecordBtn.isHidden = false
            }
        }
    }
    
    func addSwipeForView() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeAction(_:)))
        swipeDown.direction = .down
        listRecordView.addGestureRecognizer(swipeDown)
    }
    
    @objc func handleSwipeAction(_ gesture: UIGestureRecognizer) {
        isListRecordShowing = false
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomConstraintRecordView.constant = -self.listRecordView.frame.height
            self.listRecordView.frame.origin.y += self.listRecordView.frame.height
        })
    }
    func addObserver() {
        notificationCenter.addObserver(self, selector: #selector(stopRecordWhenTheEndSlideShow(_:)), name: NSNotification.Name(rawValue: keyStopRecordWhenTheEndTheSlideShow), object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(updateButtonPauseOrPlay(_:)), name: NSNotification.Name(rawValue: keyUpdateButtonPauseOrPlayRecord), object: nil)
    }
    
    @objc func updateButtonPauseOrPlay(_ notification: NSNotification){
        if isListRecordShowing{
            let cell = listRecordTableView.cellForRow(at: oldOldRowIndexPathTableView) as! ListRecordTableViewCell
            let image = UIImage(named: "Play-1")
            cell.pauseOrPlayBtn.setImage(image, for: .normal)
//            cell.pauseOrPlayBtn.tintColor = UIColor(red: 48/255, green: 125/255, blue: 251/255, alpha: 1)
        }else{
            let imagePlay = UIImage(named: "Play-1")
            playOrPauseRecordBtn.setImage(imagePlay, for: .normal)
//            playOrPauseRecordBtn.layer.cornerRadius = playOrPauseRecordBtn.frame.width / 2
//            playOrPauseRecordBtn.clipsToBounds = true
//            playOrPauseRecordBtn.layer.masksToBounds = true
//            playOrPauseRecordBtn.tintColor = UIColor(red: 48/255, green: 125/255, blue: 251/255, alpha: 1)
        }
        
    }
    @objc func stopRecordWhenTheEndSlideShow(_ notification: NSNotification) {
        
        isRecording = false
        setupRecordBtn()
        finishRecording(success: true)
        removeDisplayTimer()
        let data = ["recordFileName": recordFileName]
        notificationCenter.post(name: NSNotification.Name(rawValue: keyFinishedRecordEditSlideShowScreen), object: nil, userInfo: data)
    }
    
    @IBAction func recordSound(_ sender: Any) {
        if isRecording{
            isRecording = false
            setupRecordBtn()
            finishRecording(success: true)
            removeDisplayTimer()
            countdown = 0.0
            let data = ["recordFileName": recordFileName]
            notificationCenter.post(name: NSNotification.Name(rawValue: keyFinishedRecordEditSlideShowScreen), object: nil, userInfo: data)
        }else{
            if recordFileName != ""{
                removeRecord(recordFileName: recordFileName)
            }
            isRecording = true
            timeRecordLbl.text = "00:00"
            setupRecordBtn()
            setupRecorder()
            startRecord()
            setupCancelSaveRecordBtn()
            setDisplayTime()
            setupPlayAndShowListRecord()
            
        }
        
    }
    
    func setupRecorder(){
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                if allowed {
                    print("Allow")
                } else {
                    print("Dont Allow")
                }
            }
        } catch {
            print("failed to record!")
        }
        
        
    }
    
    func startRecord() {
        let filePathRecording = getURLRecording()
        //        let data = ["recordName": filePathRecording.lastPathComponent]
        notificationCenter.post(name: NSNotification.Name(rawValue: keyStopBackgroundEditSlideShowScreen), object: nil)
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: filePathRecording, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
    }
    
    func getURLRecording() -> URL{
        let fileManager = FileManager.default
        
        guard let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {return URL(string: "")!}
        
        let nameFolder = "RecordTheme"
        let folderPath = documentDirectory.appendingPathComponent(nameFolder, isDirectory: true)
        
        do{
            let directoryContent = try fileManager.contentsOfDirectory(atPath: folderPath.path)
            let numRecord = directoryContent.count
            recordFileName = "New_Recording_\(numRecord + 1).m4a"
//            listRecord.append(recordFileName)
            let urlNewRecord = folderPath.appendingPathComponent(recordFileName)
            return urlNewRecord
        }catch _ as NSError{
            print("error")
        }
        
        return URL(string: "")!
    }
    
    @IBAction func cancelRecord(_ sender: Any) {
        if isRecording{
            isRecording = false
            finishRecording(success: false)
            setupRecordBtn()
            setupCancelSaveRecordBtn()
            removeDisplayTimer()
            countdown = 0.0
        }else{
            setupRecordBtn()
            setupCancelSaveRecordBtn()
        }
        
        removeRecord(recordFileName: recordFileName)
        
        timeRecordLbl.text = "Press to record your voice"
        notificationCenter.post(name: NSNotification.Name(rawValue: keyCancelRecoredEditSlideShowScreen), object: nil)
        setupPlayAndShowListRecord()
    }
    
    func  removeRecord(recordFileName: String) {
        let fileManager = FileManager.default
        
        guard let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {return}
        
        let nameFolder = "RecordTheme"
        let folderPath = documentDirectory.appendingPathComponent(nameFolder, isDirectory: true)
        
        do{
            let directoryContent = try fileManager.contentsOfDirectory(atPath: folderPath.path)
            for path in directoryContent{
                if path == recordFileName{
                    let fullPath = folderPath.appendingPathComponent(path)
                    do{
                        try fileManager.removeItem(atPath: fullPath.path)
                    }catch{
                        
                    }
                }
            }
        }catch _ as NSError{
            print("error")
        }
    }
    @IBAction func saveRecord(_ sender: Any) {
        if isRecording{
            isRecording = false
            finishRecording(success: true)
            setupRecordBtn()
            setupCancelSaveRecordBtn()
            removeDisplayTimer()
            countdown = 0.0
        }else{
            setupRecordBtn()
            setupCancelSaveRecordBtn()
        }
        listRecord.append(recordFileName)
        
        timeRecordLbl.text = "Press to record your voice"
        let data = ["recordFileName": recordFileName]
        notificationCenter.post(name: NSNotification.Name(rawValue: keyFinishedRecordEditSlideShowScreen), object: nil, userInfo: data)
        setupPlayAndShowListRecord()
        recordFileName = ""
    }
    
    func setDisplayTime() {
        displayTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(displayTime), userInfo: nil, repeats: true)
    }
    var countdown: Float = 0.0
    @objc func displayTime() {
        
        if isRecording{
            countdown += 1.0
            UIView.animate(withDuration: 1, animations: {
                self.timeRecordLbl.text = String(format: "%02d:%02d", ((lround(Double(self.countdown)) / 60) % 60), lround(Double(self.countdown)) % 60)
            })
            
        }
    }
    
    func removeDisplayTimer() {
        displayTimer?.invalidate()
        if displayTimer != nil{
            displayTimer = nil
        }
        countdown = 0.0
    }
    
    @IBAction func playOrPauseRecord(_ sender: Any) {
        let imagePlay = UIImage(named: "Pause-2")
        playOrPauseRecordBtn.setImage(imagePlay, for: .normal)
//        playOrPauseRecordBtn.layer.cornerRadius = playOrPauseRecordBtn.frame.width / 2
//        playOrPauseRecordBtn.clipsToBounds = true
//        playOrPauseRecordBtn.layer.masksToBounds = true
//        playOrPauseRecordBtn.tintColor = UIColor(red: 48/255, green: 125/255, blue: 251/255, alpha: 1)
        let data = ["recordFileName": listRecord.last]
        notificationCenter.post(name: NSNotification.Name(rawValue: keyFinishedRecordEditSlideShowScreen), object: nil, userInfo: data)
    }
    
    @IBAction func showListRecord(_ sender: Any) {
//        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                self.bottomConstraintRecordView.constant = 0
                self.listRecordView.frame.origin.y -= self.listRecordView.frame.height
            })
//        }
        isListRecordShowing = true
        listRecordTableView.reloadData()
        
    }
    
}

extension MusicThemeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMusicBackground.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentItem = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeMusicCell", for: indexPath) as! TypeMusicCollectionViewCell
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        cell.backgroundMusicImageView.image = listMusicBackground[currentItem].backgroundImage
        cell.typeMusicLbl.text = listMusicBackground[currentItem].name
        if indexPath == selectedIndexPath{
            cell.typeMusicLbl.textColor = .white
        }else{
            cell.typeMusicLbl.textColor = .gray
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = listMusicThemeCollectionView.frame.height * 1.5
        let height = listMusicThemeCollectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedIndexPath = indexPath
        listMusicThemeCollectionView.reloadData()
        listMusicThemeCollectionView.scrollToItem(at: selectedIndexPath, at: .centeredHorizontally, animated: true)
        let data = ["typeMusic": listMusicBackground[indexPath.item].typeMusic] as [String: Any]
        notificationCenter.post(name: NSNotification.Name(rawValue: keyUpdateMusicBackgroundEditSideShowScreen), object: nil, userInfo: data)
    }
}

extension MusicThemeView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listRecord.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! ListRecordTableViewCell
        let nameFileRecord = (listRecord[indexPath.row].replacingOccurrences(of: "_", with: " ")).replacingOccurrences(of: ".m4a", with: "")
        cell.fileNameRecordLbl.text = nameFileRecord
        cell.imageChecked.layer.cornerRadius = cell.imageChecked.frame.width / 2
        cell.imageChecked.layer.borderColor = UIColor.gray.cgColor
        cell.imageChecked.layer.borderWidth = 1
        cell.imageChecked.image = UIImage()
        let image = UIImage(named: "Play-1")
        cell.pauseOrPlayBtn.setImage(image, for: .normal)
//        cell.pauseOrPlayBtn.tintColor = UIColor(red: 48/255, green: 125/255, blue: 251/255, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let oldCell = listRecordTableView.cellForRow(at: oldOldRowIndexPathTableView) as! ListRecordTableViewCell
        
        oldCell.imageChecked.layer.cornerRadius = oldCell.imageChecked.frame.width / 2
        oldCell.imageChecked.layer.borderColor = UIColor.gray.cgColor
        oldCell.imageChecked.layer.borderWidth = 1
        oldCell.imageChecked.image = UIImage()
        
        let cell = listRecordTableView.cellForRow(at: indexPath) as! ListRecordTableViewCell
        cell.imageChecked.layer.cornerRadius = cell.imageChecked.frame.width / 2
        cell.imageChecked.layer.borderColor = UIColor(red: 48/255, green: 125/255, blue: 251/255, alpha: 1).cgColor
        cell.imageChecked.layer.borderWidth = 1
        cell.imageChecked.image = UIImage(named: "tickIcon")?.withRenderingMode(.alwaysTemplate)
        cell.imageChecked.tintColor = UIColor(red: 48/255, green: 125/255, blue: 251/255, alpha: 1)
        let data = ["recordFileName": listRecord[indexPath.row]]
        notificationCenter.post(name: NSNotification.Name(rawValue: keyFinishedRecordEditSlideShowScreen), object: nil, userInfo: data)
        let image = UIImage(named: "Pause-2")
        cell.pauseOrPlayBtn.setImage(image, for: .normal)
//        cell.pauseOrPlayBtn.tintColor = UIColor(red: 48/255, green: 125/255, blue: 251/255, alpha: 1)
        oldOldRowIndexPathTableView = indexPath
    }
}

extension MusicThemeView: AVAudioRecorderDelegate, AVAudioPlayerDelegate{
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}

