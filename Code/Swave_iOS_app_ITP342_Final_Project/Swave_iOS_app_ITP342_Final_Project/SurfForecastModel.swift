//
//  SurfForecastModel.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 12/4/22.
//

import Foundation

class SurfForecastModel: NSObject {
    
    var surfForecastsCollection: [SurfForecast]
    private var currentIndex: Int? = nil
    
    var currentSurfForecast: SurfForecast
    
    static let sharedInstance = SurfForecastModel()
    
    override init() {
        
        self.surfForecastsCollection = []
        self.currentIndex = 0
        self.currentSurfForecast = SurfForecast(dateTimes: [""], seaLevel: [""], waterTemperature: [""], waveDirection: [""], waveHeight: [""], wavePeriod: [""])
        
        super.init()
    }
    
    func addSurfForecast(dateTimes1: String, dateTimes2: String , dateTimes3: String, seaLevel1: String, seaLevel2: String, seaLevel3: String, waterTemperature1: String, waterTemperature2: String, waterTemperature3: String, waveDirection1: String, waveDirection2: String, waveDirection3: String, waveHeight1: String,  waveHeight2: String,  waveHeight3: String, wavePeriod1: String, wavePeriod2: String, wavePeriod3: String, at index: Int) {
        
        let dateTimes = [dateTimes1, dateTimes2, dateTimes3]
        let seaLevel = [seaLevel1, seaLevel2, seaLevel3]
        let waterTemperature = [waterTemperature1, waterTemperature2, waterTemperature3]
        let waveDirection = [waveDirection1, waveDirection2, waveDirection3]
        let waveHeight = [waveHeight1, waveHeight2, waveHeight3]
        let wavePeriod = [wavePeriod1, wavePeriod2, wavePeriod3]
        
        surfForecastsCollection.append(SurfForecast(dateTimes: dateTimes, seaLevel: seaLevel, waterTemperature: waterTemperature, waveDirection: waveDirection, waveHeight: waveHeight, wavePeriod: wavePeriod))
        
        currentSurfForecast = surfForecastsCollection[surfForecastsCollection.count-1]
        
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
