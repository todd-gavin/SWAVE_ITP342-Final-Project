//
//  SurfForecast.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 12/4/22.
//

import Foundation

struct SurfForecast {
    
    public var dateTimes: [String]
    public var seaLevel: [String]
    public var waterTemperature: [String]
    public var waveDirection: [String]
    public var waveHeight: [String]
    public var wavePeriod: [String]
    
//    Getters
    func getDateTimes() -> [String] {
        return dateTimes
    }
    
    func getSeaLevel() -> [String] {
        return seaLevel
    }
    
    func getWaterTemperature() -> [String] {
        return waterTemperature
    }
    
    func getWaveDirection() -> [String] {
        return waveDirection
    }
    
    func getWaveHeight() -> [String] {
        return waveHeight
    }
    
    func getWavePeriod() -> [String] {
        return wavePeriod
    }
    
//    Setters
    mutating func setDateTimes(value: String, index: Int) {
        dateTimes[index] = value
    }
    
    mutating func setSeaLevel(value: String, index: Int) {
        seaLevel[index] = value
    }
    
    mutating func setWaterTemperature(value: String, index: Int) {
        waterTemperature[index] = value
    }
    
    mutating func setWaveDirection(value: String, index: Int) {
        waveDirection[index] = value
    }
    
    mutating func setWaveHeight(value: String, index: Int) {
        waveHeight[index] = value
    }
    
    mutating func setWavePeriod(value: String, index: Int) {
        wavePeriod[index] = value
    }
    
//    intiailizer
    init (dateTimes: [String], seaLevel: [String], waterTemperature: [String], waveDirection: [String], waveHeight: [String], wavePeriod: [String]) {
        self.dateTimes = dateTimes
        self.seaLevel = seaLevel
        self.waterTemperature = waterTemperature
        self.waveDirection = waveDirection
        self.waveHeight = waveHeight
        self.wavePeriod = wavePeriod
    }
    
}
