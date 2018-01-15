//
//  GrooveVC.swift
//  Are we Grooving?
//
//  Created by Ryan Kistner on 1/14/18.
//  Copyright © 2018 Ryan Kistner. All rights reserved.
//

import UIKit
import CoreMotion

class GrooveVC: UIViewController , UITableViewDataSource{
    var redValueForRGB : Int = 0
    var greenValueForRGB : Int = 0
    var blueValueForRGB : Int = 0
    var swapVar : String = ""
    
    var motionManager = CMMotionManager()
    let opQueue = OperationQueue()
    
    var gender : Bool?
    var incomingGender : Bool?
    var bgColor: UIColor = .white
    var colors : [UIColor] = []
    
    @IBOutlet var grooveViewOutlet: UIView!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    var incomingName: String?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = incomingName
        print("Groove loaded!")
        tableView.dataSource = self
        gender = incomingGender

        assignImage()
    
        if motionManager.isDeviceMotionAvailable{
            print("We've got a device!")
            startReadingMotionData()
        }else{
            print("No device detected!")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func endMotion(_ sender: UIButton) {
        self.motionManager.stopDeviceMotionUpdates()
    }
    
    func startReadingMotionData(){
        motionManager.deviceMotionUpdateInterval = 0.25
        
        motionManager.startDeviceMotionUpdates(to: opQueue){
            (data : CMDeviceMotion?, error: Error?) in
            
            if let myData = data {
                if (self.motionManager.isDeviceMotionActive ){
                    print("UserAccel = \(myData.userAcceleration)")
                    //X Accel
                    if (myData.userAcceleration.x > 0.04 || myData.userAcceleration.x < -0.04){
                        if(myData.attitude.yaw > 0 && myData.attitude.yaw < 1){
                            self.swapVar = "mix"
                            self.shiftAndSwap()
                            print(1)
                        }
                        else if(myData.attitude.yaw < 0 && myData.attitude.yaw > -1){
                            self.swapVar = "up"
                            self.shiftAndSwap()
                            print(1.1)
                        }
                        else{
                            self.swapVar = "down"
                            self.shiftAndSwap()
                            print(1.2)
                        }
                    }
                        //Y Accel
                    if (myData.userAcceleration.y > 0.1 || myData.userAcceleration.y < -0.1 ){
                        if(myData.attitude.yaw > 0 && myData.attitude.yaw < 1){
                            self.swapVar = "up"
                            self.shiftAndSwap()
                            print(8)
                        }
                        else if(myData.attitude.yaw < 0 && myData.attitude.yaw > -1){
                            self.swapVar = "down"
                            self.shiftAndSwap()
                            print(8.1)
                        }
                        else{
                            self.swapVar = "mix"
                            self.shiftAndSwap()
                            print(9.1)
                        }
                    }
                        //Z Accel
                    if (myData.userAcceleration.z > 1.2 || myData.userAcceleration.z < -1.2){
                        self.swapVar = "random"
                        self.shiftAndSwap()
                        print(7)
                    }
                    print("Yaw data rounded! \(myData.attitude.yaw)")
                    print(myData.attitude)
                }
            }
            if let myError = error{
                print(myError)
            }
        }
    }
    func changeColor(){
        DispatchQueue.main.async{
            if(self.redValueForRGB < 0){
                self.redValueForRGB = 35
            }else if (self.blueValueForRGB < 0){
                self.blueValueForRGB = 35
            }else if (self.greenValueForRGB < 0){
                self.greenValueForRGB = 35
            }else if (self.redValueForRGB > 255){
                self.redValueForRGB = 255
            }else if (self.greenValueForRGB > 255){
                self.greenValueForRGB = 255
            }else if (self.blueValueForRGB > 255) {
                self.blueValueForRGB = 255
            }else{
                self.bgColor = UIColor.init(red: CGFloat(UInt32(self.redValueForRGB))/255.0, green: CGFloat(UInt32(self.greenValueForRGB))/255.0, blue: CGFloat(UInt32(self.blueValueForRGB))/255.0, alpha: 100)
                self.grooveViewOutlet.backgroundColor = self.bgColor
                self.tableView.backgroundColor = self.bgColor
                self.colors.insert(self.bgColor, at: 0)
                print(self.colors.count)
                self.tableView.reloadData()
            }
        }
    }
    func shiftColor(){
        DispatchQueue.main.async{
            if(self.swapVar == "up"){
                self.redValueForRGB += 30
                self.greenValueForRGB -= 15
                self.blueValueForRGB -= 15
            }else if(self.swapVar == "down"){
                self.redValueForRGB -= 15
                self.greenValueForRGB += 30
                self.blueValueForRGB -= 15
            }else if(self.swapVar == "mix"){
                self.redValueForRGB -= 15
                self.greenValueForRGB -= 15
                self.blueValueForRGB += 30
            }else if(self.swapVar == "random"){
                self.redValueForRGB = Int(arc4random_uniform(256))
                self.blueValueForRGB = Int(arc4random_uniform(256))
                self.greenValueForRGB = Int(arc4random_uniform(256))
            }
        }
    }
    func shiftAndSwap(){
        self.shiftColor()
        self.changeColor()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        cell.textLabel?.text = ""
        return cell
    }
    func assignImage (){
            if(gender!){
                profilePic.image = #imageLiteral(resourceName: "boy")
            }else{
                profilePic.image = #imageLiteral(resourceName: "girl")
            }
    }
    
    @IBAction func dismissPage(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    }

