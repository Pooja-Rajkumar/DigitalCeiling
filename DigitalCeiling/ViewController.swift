//
//  ViewController.swift
//  DigitalCeiling
//
//  Created by porajkum on 7/20/16.
//  Copyright © 2016 porajkum. All rights reserved.
//

import UIKit
//import AVFoundation
//import AVFoundation/AVCaptureSession.h
class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var picker: UIPickerView!

    //@IBOutlet weak var intensity: UIPickerView!
    
    @IBOutlet weak var intensity: UIPickerView!
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    var intensityData: [String] = [String]()

    var pickerData: [String] = [String]()
    
    @IBOutlet weak var clicker: UIButton!
    @IBOutlet weak var imageClicker: UIImageView!
    
    @IBOutlet weak var sliderIntensity: UISlider!
   
    @IBOutlet weak var intensityLabel: UILabel!
    //@IBOutlet weak var intensityLabel: UILabel!
    
    var URL = "https://myworkplacews.cloudapps.cisco.com/lighting/setLightDetail?status=ON&brightness=5&mode=COOLWHITE&bldgid=SJC12&flrid=3&spid=C17A&app=cisco_maps&userid=sdasary"
    
    var brightness = 5
    
    //var captureSession:AVCapturesession?
    //var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    //var qrCodeFrameView:UIView?
    
    var buttonTapCounts = 0;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.picker.delegate = self
        self.picker.dataSource = self
        self.picker.tag = 1
        
        clicker.layer.zPosition = 1
        imageClicker.layer.zPosition = 0
        
        self.intensity.delegate = self
        self.intensity.dataSource = self
        self.intensity.tag = 2
        
        
        pickerData = ["Warm White", "Cool White", "Daylight","Video"]
        intensityData = ["1","2","3","4","5","6","7","8","9","10"]
        
        mySwitch.on = false
        
        
        
    
    }

    
    func getRequests(requester: NSMutableURLRequest) -> NSURLSessionDataTask {
        let task = NSURLSession.sharedSession().dataTaskWithRequest(requester) {
            data, response, error in
            // Check for error
            if error != nil{
                print("error=\(error)")
                return
            }
            // Print out response string
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            // Convert server json response to NSDictionary
            do {
                if let convertedJsonIntoDict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    // Print out dictionary
                    print(convertedJsonIntoDict)
                    // Get value by key
                    // let firstNameValue = convertedJsonIntoDict["userName"] as? String
                    //  print(firstNameValue!)
                }
            } catch let error as NSError {
                print(error.localizedDescription) }
        }
       return task
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            return pickerData.count
        } else if pickerView.tag == 2{
            return intensityData.count
        }
        
        return 1
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return pickerData[row]
        } else if pickerView.tag == 2{
            return intensityData[row]
        }
        return pickerData[row]
    }

    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            if row == 0 { // if warm white option is selected
               URL = "https://myworkplacews.cloudapps.cisco.com/lighting/setLightDetail?status=ON&brightness=" + String(brightness) + "&mode=WARMWHITE&bldgid=SJC12&flrid=3&spid=C17A&app=cisco_maps&userid=sdasary"
                let newURL = NSURL(string: URL)!
                
                let request = NSMutableURLRequest(URL:newURL)
                request.HTTPMethod = "GET"
                let task = getRequests(request)
                task.resume()
                NSLog(URL)
            }
            if row == 1 { // if cool white option is selected
                URL = "https://myworkplacews.cloudapps.cisco.com/lighting/setLightDetail?status=ON&brightness=" + String(brightness) + "&mode=COOLWHITE&bldgid=SJC12&flrid=3&spid=C17A&app=cisco_maps&userid=sdasary"
                let newURL = NSURL(string: URL)!
                
                let request = NSMutableURLRequest(URL:newURL)
                request.HTTPMethod = "GET"
                let task = getRequests(request)
                task.resume()
                //UIApplication.sharedApplication().openURL(newURL)
                NSLog(URL)
            }
            if row == 2 { // if daylight setting is selected
                URL = "https://myworkplacews.cloudapps.cisco.com/lighting/setLightDetail?status=ON&brightness=" + String(brightness) + "&mode=DAYLIGHT&bldgid=SJC12&flrid=3&spid=C17A&app=cisco_maps&userid=sdasary"
                let newURL = NSURL(string: URL)!
                let request = NSMutableURLRequest(URL:newURL)
                request.HTTPMethod = "GET"
                let task = getRequests(request)
                task.resume()
                
                //UIApplication.sharedApplication().openURL(newURL)
                NSLog(URL)
            }
            if row == 3 { // if video setting is selected
                URL = "https://myworkplacews.cloudapps.cisco.com/lighting/setLightDetail?status=ON&brightness=" + String(brightness)+"&mode=TELEPRESENCE&bldgid=SJC12&flrid=3&spid=C17A&app=cisco_maps&userid=sdasary"
                let newURL = NSURL(string: URL)!
                let request = NSMutableURLRequest(URL:newURL)
                request.HTTPMethod = "GET"
                let task = getRequests(request)
                task.resume()
                //UIApplication.sharedApplication().openURL(newURL)
                NSLog(URL)
            }
            
        }
        if pickerView.tag == 2 {
           let newBrightness = row + 1
           let replace = URL.stringByReplacingOccurrencesOfString("brightness="+String(brightness), withString: "brightness=" + String(newBrightness))
           brightness = row + 1
           let newURL = NSURL(string: replace)!
           let request = NSMutableURLRequest(URL:newURL)
           request.HTTPMethod = "GET"
           let task = getRequests(request)
           task.resume()
            
            //UIApplication.sharedApplication().openURL(newURL)
           
        }
    }
    
    
    @IBOutlet weak var onButton: UIButton!
    
    @IBAction func OnButton(sender: AnyObject) {
        buttonTapCounts += 1
        if(buttonTapCounts % 2 == 0 ){
            let newURL = NSURL(string: "https://myworkplacews.cloudapps.cisco.com/lighting/setLightDetail?status=OFF&bldgid=SJC12&flrid=3&spid=C17A&app=cisco_maps&userid=sdasary")!
            let request = NSMutableURLRequest(URL:newURL)
            request.HTTPMethod = "GET"
            let task = getRequests(request)
            task.resume()
        } else {
            let newURL = NSURL(string: "https://myworkplacews.cloudapps.cisco.com/lighting/setLightDetail?status=ON&bldgid=SJC12&flrid=3&spid=C17A&app=cisco_maps&userid=sdasary")!
            let request = NSMutableURLRequest(URL:newURL)
            request.HTTPMethod = "GET"
            let task = getRequests(request)
            task.resume()
        }
        
    
    }
    
    
    
    @IBAction func onOff(sender: AnyObject) {
        if mySwitch.on {
            let newURL = NSURL(string: "https://myworkplacews.cloudapps.cisco.com/lighting/setLightDetail?status=ON&bldgid=SJC12&flrid=3&spid=C17A&app=cisco_maps&userid=sdasary")!
            let request = NSMutableURLRequest(URL:newURL)
            request.HTTPMethod = "GET"
            let task = getRequests(request)
            task.resume()
            //UIApplication.sharedApplication().openURL(newURL)
            
            
        }
        else {
           let newURL = NSURL(string: "https://myworkplacews.cloudapps.cisco.com/lighting/setLightDetail?status=OFF&bldgid=SJC12&flrid=3&spid=C17A&app=cisco_maps&userid=sdasary")!
            let request = NSMutableURLRequest(URL:newURL)
            request.HTTPMethod = "GET"
            let task = getRequests(request)
            task.resume()
            
    
            //UIApplication.sharedApplication().openURL(newURL)
            
        }
    }
    
    
    @IBAction func sliderChange(sender: AnyObject) {
        let newBrightness = Int(sliderIntensity.value)
        intensityLabel.text = "\(newBrightness)"
        let replace = URL.stringByReplacingOccurrencesOfString("brightness="+String(brightness), withString: "brightness=" + String(newBrightness))
        brightness = newBrightness
        let newURL = NSURL(string: replace)!
        let request = NSMutableURLRequest(URL:newURL)
        request.HTTPMethod = "GET"
        let task = getRequests(request)
        task.resume()
        NSLog(replace)
    }
    
    @IBOutlet weak var pref: UIButton!
    
    @IBAction func getPref(sender: AnyObject) {
        self.performSegueWithIdentifier("mover", sender: nil)
    }

}

