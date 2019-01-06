//
//  ViewController.swift
//  Timer
//
//  Created by Zhijie (Jenny) Xu on 8/24/18.
//  Copyright © 2018 Zhijie (Jenny) Xu. All rights reserved.
//

/*

 ideas to do:
 
 - fix the labels after clearing, then restarting [[[[[ GOT IT
 - format the duration labels like 00:00:00
 - use a separate label for "average" or always show "00:00:00" next to "average"
 - record the start and stop time for each duration
 - learn to use "navigation view controller"
 - allow for the user to create separate timer categories like "commute", "sleep" etc.
 
 
 
*/

import UIKit

class ViewController: UIViewController, UITableViewDataSource{

    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var myAverage: UILabel!
    
    
    
    private var data : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    var runs = true
    var startingTime = Date.init()
    var clock = Timer()
    
    @IBAction func ButtonBeingPressed(_ sender: UIButton) {
        if runs{
            runs = false
            startingTime = Date.init()
            myButton.setTitle("Stop", for: .normal)
            labelBeingChanged()
            clock = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(labelBeingChanged), userInfo: nil, repeats: true)
        }else{
            runs = true
            myButton.setTitle("Start", for: .normal)
            clock.invalidate()
            let dur = getDuration(t1: Date.init(), t2: startingTime)
            myLabel.text = dur
            UserDefaults.standard.set(dur, forKey: "duration")
            insertNewDuration()
            let ave = "        " + showAverage(changingInterval: 0.0)
            myAverage.text = ave
            UserDefaults.standard.set(ave, forKey: "average")
        }
    }
    
    func labelBeingChanged() {
        let duration = Date.init().timeIntervalSince(startingTime)
        myLabel.text = formatter(interval: duration)
        if data.count == 0 {
            myAverage.text = "        " + myLabel.text!
        }else{
            myAverage.text = "        " + showAverage(changingInterval: duration)
        }
    }
    
    func getDuration(t1: Date, t2: Date) -> String{
        let result = t1.timeIntervalSince(t2)
        let formattedResult = formatter(interval: result)
        return formattedResult
        //return formatting(num: result)
    }
    
    func formatter(interval : TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [ .hour, .minute, .second]
        formatter.zeroFormattingBehavior = [ .pad]
        let formattedResult = formatter.string(from: interval)
        return formattedResult!
    }
    
    func insertNewDuration(){
        data.insert(getDuration(t1: Date.init(), t2: startingTime), at: 0)
        UserDefaults.standard.set(data, forKey: "TimeArray")
        
        // tableView.reloadData()
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
    
    func formatting(num: TimeInterval) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        let formattedNum = formatter.string(from: num as NSNumber)
        return formattedNum!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showAverage(changingInterval: TimeInterval) -> String {
        //let doubleData = data.map{ Double($0)!}
        //let denominator = (doubleData.count)
        //var sum = 0.0 + changingInterval
        //for i in 0..<denominator {
            //sum += doubleData[i]
        //}
        //let result = sum/Double(denominator)
        //let rresult = formatting(num: result)
        //UserDefaults.standard.set(rresult, forKey: "average")
        //return rresult
        return "pause"
    }
    
    //@IBAction func calculateAverage(_ sender: UIButton) {
        //let doubleData = data.map{ Double($0)!}
        //let denominator = (doubleData.count)
        //var sum = 0.0
        //for i in 0..<denominator {
            //sum += doubleData[i]
        //}
        //let result = sum/Double(denominator)
        //let rresult = formatting(num: result)
        //myAverage.text = rresult
        //UserDefaults.standard.set(rresult, forKey: "average")
    //}
    
    
    @IBAction func clearButtonPressed(_ sender: roundStartButton) {
         print("clear start")
        data.removeAll()
        UserDefaults.standard.set(data, forKey: "TimeArray")
         print(data)
        tableView.reloadData()
         print("clear pressed")
        myLabel.text = ""
        UserDefaults.standard.set("", forKey: "duration")
        myAverage.text = "        "
        UserDefaults.standard.set("        ", forKey: "average")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let x = UserDefaults.standard.object(forKey: "duration") as? String{
            myLabel.text = x
        }
        
        if let y = UserDefaults.standard.object(forKey: "average") as? String{
            myAverage.text = y
        }
        
        if let array = UserDefaults.standard.object(forKey: "TimeArray") as? [String]{
            print(array)
            data = array
            tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellsIden")
        let text = data[indexPath.row]
        cell?.textLabel?.text = text
        return cell!
    }

    var timerEvent: UITextField?
    
    @IBAction func addTime(_ sender: Any) {
        let alertController = UIAlertController(title: "Enter your activity: ", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: timerEvent)
    }
}

func timerEvent(textField: UITextField!){
    timerEvent = textField
}
