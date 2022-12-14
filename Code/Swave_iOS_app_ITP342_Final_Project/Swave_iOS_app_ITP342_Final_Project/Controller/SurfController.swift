//
//  surfMatchController.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 11/30/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Foundation

class SurfController: UIViewController {
    
    @IBOutlet weak var latOutlet: UILabel!
    @IBOutlet weak var longOutlet: UILabel!
    
    @IBOutlet weak var dateTime1Outlet: UILabel!
    @IBOutlet weak var seaLevel1Outlet: UILabel!
    @IBOutlet weak var waterTemp1Outlet: UILabel!
    @IBOutlet weak var waveDirection1Outlet: UILabel!
    @IBOutlet weak var waveHeight1Outlet: UILabel!
    @IBOutlet weak var wavePeriod1Outlet: UILabel!
    
    @IBOutlet weak var dateTime2Outlet: UILabel!
    @IBOutlet weak var seaLevel2Outlet: UILabel!
    @IBOutlet weak var waterTemp2Outlet: UILabel!
    @IBOutlet weak var waveDirection2Outlet: UILabel!
    @IBOutlet weak var waveHeight2Outlet: UILabel!
    @IBOutlet weak var wavePeriod2Outlet: UILabel!
    
    @IBOutlet weak var dateTime3Outlet: UILabel!
    @IBOutlet weak var seaLevel3Outlet: UILabel!
    @IBOutlet weak var waterTemp3Outlet: UILabel!
    @IBOutlet weak var waveDirection3Outlet: UILabel!
    @IBOutlet weak var waveHeight3Outlet: UILabel!
    @IBOutlet weak var wavePeriod3Outlet: UILabel!
    
    private var userModel = UserModel.sharedInstance
    private var surfForecastModel = SurfForecastModel.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#function) Surf Match Page")
        
        let startDateTime = getCurrentDataTime()
        let endDateTime = getEndDateTime(startDateTime: startDateTime)
        let lat = userModel.getLocationLat()
        let long = userModel.getLocationLong()
        callStormglassAPI(lat: String(lat), long: String(long), startDateTime: startDateTime, endDateTime: endDateTime)

    }
    
    
    @IBAction func loadClickedAction(_ sender: UIButton) {
        print("\(#function)")
        let startDateTime = getCurrentDataTime()
        let endDateTime = getEndDateTime(startDateTime: startDateTime)
        let lat = userModel.getLocationLat()
        let long = userModel.getLocationLong()
        callStormglassAPI(lat: String(lat), long: String(long), startDateTime: startDateTime, endDateTime: endDateTime)
    }
    
    
    @IBAction func surfMapClickedAction(_ sender: UIButton) {
        print("\(#function)")
        self.performSegue (withIdentifier: "navigateToSurfMap", sender: self)
    }
    
    
    @IBAction func createSurfEventClickedAction(_ sender: UIButton) {
        print("\(#function)")
        self.performSegue (withIdentifier: "navigateToCreateEvent", sender: self)
    }
    
    
    func convertISOtoReadableTime(time: String) -> String {
        
        let dateFormatter = ISO8601DateFormatter()
        
        if let date = dateFormatter.date(from: time) {
            
            let pstFormatter = DateFormatter()
            pstFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
            pstFormatter.timeZone = TimeZone(abbreviation: "PST")

            let pstString = pstFormatter.string(from: date)
            print(pstString) // 12/03/2022 04:00 PM
            return pstString
            
        } else {
            return time
        }
        
    }
    
    func getCurrentDataTime() -> String {
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]

        let date = Date()

        let isoString = dateFormatter.string(from: date)
        print(isoString) // 2022-12-04T00:00:00
        
        return isoString

    }
    
    func getEndDateTime(startDateTime: String) -> String {
        
        let dateFormatter = ISO8601DateFormatter()

            if let date = dateFormatter.date(from: startDateTime) {
                let threeHours: TimeInterval = 2 * 60 * 60 // 2 hours in seconds
                let newDate = date.addingTimeInterval(threeHours)
                return dateFormatter.string(from: newDate)
                
            } else {
                return startDateTime
            }
    }
    
    func callStormglassAPI(lat: String, long: String, startDateTime: String, endDateTime: String) {

        // Set the base URL for the API
        var urlComponents = URLComponents(string: "https://api.stormglass.io/v2/weather/point?")!

//        let API_KEY = String("0dcf4c2e-70e9-11ed-a654-0242ac130002-0dcf4c92-70e9-11ed-a654-0242ac130002")
//        let API_KEY = String("b574ba82-743f-11ed-bce5-0242ac130002-b574bb4a-743f-11ed-bce5-0242ac130002")
        let API_KEY = String("dfc9cdc4-744c-11ed-bc36-0242ac130002-dfc9ce32-744c-11ed-bc36-0242ac130002")
        

        let params = "seaLevel,waterTemperature,waveDirection,waveHeight,wavePeriod"

        // Set the query parameters
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lng", value: long),
            URLQueryItem(name: "params", value: params),
            URLQueryItem(name: "start", value: startDateTime),
            URLQueryItem(name: "end", value: endDateTime),
            URLQueryItem(name: "source", value: "sg")
        ]

        // Create the request
        var request = URLRequest(url: urlComponents.url!)

        // Set the header parameters
        request.setValue(API_KEY, forHTTPHeaderField: "Authorization")
        
        print("Request URL: \(request)")

        // Use URLSession to send the request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check for errors
            if let error = error {
                print(error)
                return
            }

            // Check for a successful response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("API returned an unsuccessful status code")
                return
            }

            // Check for data in the response
            guard let data = data else {
                print("No data was returned by the API")
                return
            }

            // Parse the response data into a JSON object
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])

                // Use the JSON object here
                print(json)
                DispatchQueue.main.async {
                    self.updateSurfForecastModelSingleton(jsonRepsonse: json)
                    
                    self.updateUI()
                }
                
            } catch {
                print(error)
            }
            
        }.resume()

    }
    
    // 1. Update SurfForecastModel Singleton
    
    func updateSurfForecastModelSingleton(jsonRepsonse: Any) {

        // dictionary
        if let jsonDict = jsonRepsonse as? [String: Any] {
            // list
            if let forecasts = jsonDict["hours"] as? [[String: Any]] {
                
                let forecast1 = forecasts[0]
                
                let seaLevel1raw = forecast1["seaLevel"] as? [String: Any]
                let seaLevel1 = String(seaLevel1raw?["sg"] as! Double)
                
                var time1 = forecast1["time"] as? String
                time1 = convertISOtoReadableTime(time: time1!)

                let waterTemperature1raw = forecast1["waterTemperature"] as? [String: Any]
                let waterTemperature1 = String(waterTemperature1raw?["sg"] as! Double)
                
                let waveDirection1raw = forecast1["waveDirection"] as? [String: Any]
                let waveDirection1 = String(waveDirection1raw?["sg"] as! Double)
                
                let waveHeight1raw = forecast1["waveHeight"] as? [String: Any]
                let waveHeight1 = String(waveHeight1raw?["sg"] as! Double)
                
                let wavePeriod1raw = forecast1["wavePeriod"] as? [String: Any]
                let wavePeriod1 = String(wavePeriod1raw?["sg"] as! Double)
                
                // ****************
                let forecast2 = forecasts[1]
                
                let seaLevel2raw = forecast2["seaLevel"] as? [String: Any]
                let seaLevel2 = String(seaLevel2raw?["sg"] as! Double)
                
                var time2 = forecast2["time"] as? String
                time2 = convertISOtoReadableTime(time: time2!)

                let waterTemperature2raw = forecast2["waterTemperature"] as? [String: Any]
                let waterTemperature2 = String(waterTemperature2raw?["sg"] as! Double)
                
                let waveDirection2raw = forecast2["waveDirection"] as? [String: Any]
                let waveDirection2 = String(waveDirection2raw?["sg"] as! Double)
                
                let waveHeight2raw = forecast2["waveHeight"] as? [String: Any]
                let waveHeight2 = String(waveHeight2raw?["sg"] as! Double)
                
                let wavePeriod2raw = forecast2["wavePeriod"] as? [String: Any]
                let wavePeriod2 = String(wavePeriod2raw?["sg"] as! Double)
                
                // ****************
                let forecast3 = forecasts[2]
                
                let seaLevel3raw = forecast3["seaLevel"] as? [String: Any]
                let seaLevel3 = String(seaLevel3raw?["sg"] as! Double)
                
                var time3 = forecast3["time"] as? String
                time3 = convertISOtoReadableTime(time: time3!)

                let waterTemperature3raw = forecast3["waterTemperature"] as? [String: Any]
                let waterTemperature3 = String(waterTemperature3raw?["sg"] as! Double)
                
                let waveDirection3raw = forecast3["waveDirection"] as? [String: Any]
                let waveDirection3 = String(waveDirection3raw?["sg"] as! Double)
                
                let waveHeight3raw = forecast3["waveHeight"] as? [String: Any]
                let waveHeight3 = String(waveHeight3raw?["sg"] as! Double)
                
                let wavePeriod3raw = forecast3["wavePeriod"] as? [String: Any]
                let wavePeriod3 = String(wavePeriod3raw?["sg"] as! Double)
                
                print("Params:\n\(time1!)\(time2!)\(time3!)\n\(seaLevel1)\(seaLevel2)\(seaLevel3)\n\(waterTemperature1)\(waterTemperature2)\(waterTemperature3)\n\(waveDirection1)\(waveDirection2)\(waveDirection3)\n\(waveHeight1)\(waveHeight2)\(waveHeight3)\n\(wavePeriod1)\(wavePeriod2)\(wavePeriod3)\n")
                
                surfForecastModel.addSurfForecast(dateTimes1: time1!, dateTimes2: time2!, dateTimes3: time3!, seaLevel1: seaLevel1, seaLevel2: seaLevel2, seaLevel3: seaLevel3, waterTemperature1: waterTemperature1, waterTemperature2: waterTemperature2, waterTemperature3: waterTemperature3, waveDirection1: waveDirection1, waveDirection2: waveDirection2, waveDirection3: waveDirection3, waveHeight1: waveHeight1, waveHeight2: waveHeight2, waveHeight3: waveHeight3, wavePeriod1: wavePeriod1, wavePeriod2: wavePeriod2, wavePeriod3: wavePeriod3, at: 0)
                
//                self.updateUI()

            }
        }
    }
    
    // 2. Update UI from data inside the SurfForecastModel Singleton
    
    func updateUI() {
        
        let forecast = surfForecastModel.getCurrentSurfForecast()
        
        if forecast.getDateTimes()[0] != "" {
            
            dateTime1Outlet.text = forecast.getDateTimes()[0]
            seaLevel1Outlet.text = forecast.getSeaLevel()[0]
            waterTemp1Outlet.text = forecast.getWaterTemperature()[0]
            waveDirection1Outlet.text = forecast.getWaveDirection()[0]
            waveHeight1Outlet.text = forecast.getWaveHeight()[0]
            wavePeriod1Outlet.text = forecast.getWavePeriod()[0]
            
            dateTime2Outlet.text = forecast.getDateTimes()[1]
            seaLevel2Outlet.text = forecast.getSeaLevel()[1]
            waterTemp2Outlet.text = forecast.getWaterTemperature()[1]
            waveDirection2Outlet.text = forecast.getWaveDirection()[1]
            waveHeight2Outlet.text = forecast.getWaveHeight()[1]
            wavePeriod2Outlet.text = forecast.getWavePeriod()[1]
            
            dateTime3Outlet.text = forecast.getDateTimes()[2]
            seaLevel3Outlet.text = forecast.getSeaLevel()[2]
            waterTemp3Outlet.text = forecast.getWaterTemperature()[2]
            waveDirection3Outlet.text = forecast.getWaveDirection()[2]
            waveHeight3Outlet.text = forecast.getWaveHeight()[2]
            wavePeriod3Outlet.text = forecast.getWavePeriod()[2]
            
            latOutlet.text = String(userModel.getLocationLat())
            longOutlet.text = String(userModel.getLocationLong())
            
            print("Surf Weather UI Updated")
            
        }
    }
}
