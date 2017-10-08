//
//  ViewController.swift
//  FBTechGame
//
//  Created by SenthilKumar on 9/27/17.
//  Copyright © 2017 personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var timerLabel: UILabel!
    
    let itemKey = "score"
    var itemValue: String?
    
    
    var seconds = 60
    var timer = Timer()
    
    var isTimerRunning = false
    var resumeTapped = false

    
    //MARK: Play
    @IBAction func playAction(_ sender: Any) {
        
        runTimer()
        
    }
    
    //MARK: Stop
    @IBAction func stopAction(_ sender: Any) {
        
        
        timer.invalidate()
        isTimerRunning = false
        
        print("Saving Score = \(timerLabel.text!)")
        
        saveData(value: timerLabel.text!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     //MARK: Load Data
    func loadData() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        
        let documentDirectory = paths[0] as! String
        let path = documentDirectory.appending("scorelist.plist")
        
        let fileManager = FileManager.default
        if(!fileManager.fileExists(atPath: path)) {
            if let bundlePath = Bundle.main.path(forResource: "scorelist", ofType: "plist"){
                let result = NSMutableDictionary(contentsOfFile: bundlePath)
                print("Bundle File scorelist.plist is: -> \(String(describing: result?.description))")
                do {
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                } catch {
                    print("Copy Failured!")
                }
            } else {
                print("File scorelist.plist not found!")
            }
        } else{
            print("File scorelist.plist already at path!")
        }
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        print("Load scorelist.plist is -> \(String(describing: resultDictionary?.description))")
        
        let myDict = NSDictionary(contentsOfFile: path)
        if let dict = myDict {
            itemValue = dict.object(forKey: itemKey) as? String
           // print(itemValue!)
            
        } else {
            print("Load failured!")
        }
    }
    
    
    //MARK: Save Data
    func saveData(value:String) {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentDirectory = paths.object(at: 0) as! String
        let path = documentDirectory.appending("scorelist.plist")
        
        let dict: NSMutableDictionary = [:]
        dict.setObject(value, forKey: itemKey as NSCopying)
        dict.write(toFile: path, atomically: true)
        print("Saved")
    }

    
    
//    func saveData(value:String) {
//        
//        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
//        let documentDirectory = paths.object(at: 0) as! String
//        let path = documentDirectory.appending("scorelist.plist")
//
//        
//        if let plistArray = NSMutableArray(contentsOfFile: path) {
//            plistArray.add(value)
//            //plistArray.add(indexValue+5)
//            plistArray.write(toFile: path, atomically: false)
//            print("Saved")
//
//        }
//    }
//  
    
    // Timer
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            //Send alert to indicate time's up.
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
            timerLabel.text = String(seconds)
          
        }
    }

    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }

}

