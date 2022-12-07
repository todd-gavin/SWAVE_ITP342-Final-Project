//
//  SurfForecastModel.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 12/4/22.
//

import Foundation

class SurfForecastModel: NSObject {
    
    // Define an array that will store SurfForecast objects
    var surfForecastsCollection: [SurfForecast]

    // Define a private variable that will store the current index in surfForecastsCollection
    private var currentIndex: Int? = nil

    // Define a variable that will store the current SurfForecast object
    var currentSurfForecast: SurfForecast

    // Define a shared instance of the SurfForecastModel
    static let sharedInstance = SurfForecastModel()

    // Override the parent class' initializer
    override init() {
        
        // Initialize surfForecastsCollection as an empty array
        self.surfForecastsCollection = []
        
        // Initialize currentIndex to 0
        self.currentIndex = 0
        
        // Initialize currentSurfForecast with empty values
        self.currentSurfForecast = SurfForecast(dateTimes: [""], seaLevel: [""], waterTemperature: [""], waveDirection: [""], waveHeight: [""], wavePeriod: [""])
        
        // Call the parent class' initializer
        super.init()
    }

    // Define a function that adds a SurfForecast object to surfForecastsCollection
    func addSurfForecast(dateTimes1: String, dateTimes2: String , dateTimes3: String, seaLevel1: String, seaLevel2: String, seaLevel3: String, waterTemperature1: String, waterTemperature2: String, waterTemperature3: String, waveDirection1: String, waveDirection2: String, waveDirection3: String, waveHeight1: String,  waveHeight2: String,  waveHeight3: String, wavePeriod1: String, wavePeriod2: String, wavePeriod3: String, at index: Int) {
        
        // Create arrays of the given input strings
        let dateTimes = [dateTimes1, dateTimes2, dateTimes3]
        let seaLevel = [seaLevel1, seaLevel2, seaLevel3]
        let waterTemperature = [waterTemperature1, waterTemperature2, waterTemperature3]
        let waveDirection = [waveDirection1, waveDirection2, waveDirection3]
        let waveHeight = [waveHeight1, waveHeight2, waveHeight3]
        let wavePeriod = [wavePeriod1, wavePeriod2, wavePeriod3]
        
        // Create a new SurfForecast object using the input arrays
        surfForecastsCollection.append(SurfForecast(dateTimes: dateTimes, seaLevel: seaLevel, waterTemperature: waterTemperature, waveDirection: waveDirection, waveHeight: waveHeight, wavePeriod: wavePeriod))
        
        // Set the currentSurfForecast to the newly added SurfForecast object
        currentSurfForecast = surfForecastsCollection[surfForecastsCollection.count-1]
        
        // Update currentIndex
        if (surfForecastsCollection.count == 1) {
            currentIndex = 0
        } else if (currentIndex! >= index) {
            currentIndex! += 1
        }
        
    }
    
    func removeSurfForecast(at index: Int) {
        if (index <= surfForecastsCollection.count-1 && index >= 0) {
            surfForecastsCollection.remove(at: index)
            
            if (currentIndex! < 0 && surfForecastsCollection.count != 0) {
                currentIndex! = 0
            }
            else if (surfForecastsCollection.count == 0) {
                currentIndex = nil
            }
            
        }
    }
    
    func getCurrentSurfForecast() -> SurfForecast {
        return currentSurfForecast
    }
    
}
