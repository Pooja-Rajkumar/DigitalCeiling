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
    
    @IBOutlet weak var intensity: UIPickerView!
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    var intensityData: [String] = [String]()

    var pickerData: [String] = [String]()
    
    @IBOutlet weak var clicker: UIButton!
    
    @IBOutlet weak var imageClicker: UIImageView!
    
    @IBOutlet weak var sliderIntensity: UISlider!
   
    @IBOutlet weak var intensityLabel: UILabel!

    var URL = "https://myworkplacews.cloudapps.cisco.com/lighting/setLightDetail?status=ON&brightness=5&mode=COOLWHITE&bldgid=SJC12&flrid=3&spid=C17A&app=cisco_maps&userid=sdasary"
    
    var brightness = 5 // Set the default brightness to 5.

    var buttonTapCounts = 0; // Button Tap Counts is to calculate how many times the button is tapped.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.picker.delegate = self // Set the theme picker delegate and data source. Give it a tag of 1 so we know which picker to choose in our function.
        self.picker.dataSource = self
        self.picker.tag = 1
        
        clicker.layer.zPosition = 1 // This is layering the button (on/off) on TOP of the image
        imageClicker.layer.zPosition = 0 // This was done because I wanted to add a clickable image. So, I just layed over an image on top of the button.
        
        self.intensity.delegate = self // Set the intensity picker delegate and data source. Give it a tag of 2 so we know which picker to choose in our function.
        self.intensity.dataSource = self
        self.intensity.tag = 2
        
        
        pickerData = ["Warm White", "Cool White", "Daylight","Video"] // Populate the picker theme data
        intensityData = ["1","2","3","4","5","6","7","8","9","10"] // Populate the intensity theme data
        mySwitch.on = false // set the default for the switch to false = off

    
    }

    // Get the HTTP request
    // I used a tutorial for this portion of the code. It slightly editted it for the purpose of this application (I needed it to set the task)
    // The tutorial can be found here: http://swiftdeveloperblog.com/http-get-request-example-in-swift/
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

    // Overview: This is the picker for the different themes in which each theme is given a tag. 
    // Create the URL, replace it with the new picked value, and send an HTTP Get request.
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
    
    // OVERVIEW: This button is layed OVER the image. So, when you click the "image" you are really clicking the button.
    // Once tapped, we keep track of how many times the button is tapped.
    // If it is tapped an even number of times, we turn the light off
    // If it is tapped an off number of times, we turn the light on
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
    
    
    // OVERVIEW: This switch (which I moved to the top of the app but I recommend you delete) Simply turns the light on/off.
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
    
    
    // OVERVIEW: Change the brightness based on the slider value of the brightness.
    // The current brightness is reflected on a label, called IntensityLabel that is below the slider.
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

