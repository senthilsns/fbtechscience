//
//  ScoreViewController.swift
//  FBTechGame
//
//  Created by SenthilKumar on 9/27/17.
//  Copyright © 2017 personal. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet var tableview: UITableView!
    let itemKey = "score"
    var itemValue: String?
    
    var localArr :[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        self.title = "Score Board"
        loadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "GameCell"
        var cell: GameCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? GameCell
        if cell == nil {
            
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? GameCell
        }
        
        cell.scoreLabel.text = localArr[indexPath.row]
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

 
    //MARK: Load Data with Plist
    func loadData() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        
        let documentDirectory = paths[0] as! String
        let path = documentDirectory.appending("scorelist.plist")
        
        let fileManager = FileManager.default
        if(!fileManager.fileExists(atPath: path)) {
            if let bundlePath = Bundle.main.path(forResource: "scorelist", ofType: "plist"){
                let result = NSMutableDictionary(contentsOfFile: bundlePath)
                print("Bundle File list.plist is: -> \(String(describing: result?.description))")
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
            localArr.append(itemValue!)
            
        } else {
            print("Load failured!")
        }
    }
    

}
