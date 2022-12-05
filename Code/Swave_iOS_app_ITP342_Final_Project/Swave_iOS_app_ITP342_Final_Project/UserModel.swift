//
//  UsersModel.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 12/3/22.
//

import Foundation

class UserModel: NSObject {
    var user: User
    private var email: String
    private var password: String
    
    static let sharedInstance = UserModel()
    
    override init() {
        self.user = User(user_id: "N/A", username: "N/A", full_name: "N/A", short_bio: "N/A", age: 0, experience_level: 0, surboard_type: 0, surf_status: 0, primary_location_lat: 0, primary_location_long: 0)
        self.email = "N/A"
        self.password = "N/A"
        super.init()
    }
    
//    Setters for current user
    func setUserID(id: String) {
        user.user_id = id
        print("Succesfully set user_id to: \(user.user_id)")
    }
    
    func setUsername(username: String) {
        user.username = username
        print("Succesfully set username to: \(user.username)")
    }
    
    func setFullName(name: String) {
        user.full_name = name
        print("Succesfully changed full_name to: \(user.full_name)")
    }
    
    func setShortBio(bio: String) {
        user.short_bio = bio
        print("Succesfully changed short_bio to: \(user.short_bio)")
    }
    
    func setAge(age: Int) {
        user.age = age
        print("Succesfully changed age to: \(user.age)")
    }
    
    func setExperienceLevel(level: Int) {
        user.experience_level = level
        print("Succesfully changed experience_level to: \(user.experience_level)")
    }
    
    func setSurfboardType(board: Int) {
        user.surboard_type = board
        print("Succesfully changed surfboard_type to: \(user.surboard_type)")
    }
    
    func setSurfStatus(status: Int) {
        user.surf_status = status
        print("Succesfully changed surf_status to: \(user.surf_status)")
    }
    
    func setLocationLat(lat: Double) {
        user.primary_location_lat = lat
        print("Succesfully changed primary_location_lat to: \(user.primary_location_lat)")
    }
    
    func setLocationLong(long: Double) {
        user.primary_location_long = long
        print("Succesfully changed primary_location_long to: \(user.primary_location_long)")
    }
    
    func setEmail(email: String) {
        self.email = email
        print("Succesfully set email to: \(self.email)")
    }
    
    func setPassword(password: String) {
        self.password = password
        print("Succesfully set password to: \(self.password)")
    }
    
//    Getters for current user
    func getUserID() -> String {
        print("Getting user_id: \(user.user_id)")
        return user.user_id
    }
    
    func getUsername() -> String {
        print("Getting username: \(user.username)")
        return user.username
    }
    
    func getFullName() -> String {
        print("Getting full_name: \(user.full_name)")
        return user.full_name
    }
    
    func getShortBio() -> String {
        print("Getting short_bio: \(user.short_bio)")
        return user.short_bio
    }
    
    func getAge() -> Int {
        print("Getting age: \(user.age)")
        return user.age
    }
    
    func getExperienceLevel() -> Int {
        print("Getting experience_level: \(user.experience_level)")
        return user.experience_level
    }
    
    func getSurfboardType() -> Int {
        print("Getting surfboard_type: \(user.surboard_type)")
        return user.surboard_type
    }
    
    func getSurfStatus() -> Int {
        print("Getting surf_status: \(user.surf_status)")
        return user.surf_status
    }
    
    func getLocationLat() -> Double {
        print("Getting primary_location_lat: \(user.primary_location_lat)")
        return user.primary_location_lat
    }
    
    func getLocationLong() -> Double {
        print("Getting primary_location_long: \(user.primary_location_long)")
        return user.primary_location_long
    }
    
    func getAllUserInfoLocal() {
        print("All Current User Info Local:\nuser_id: \(user.user_id)\nusername: \(user.username)\nfull_name: \(user.full_name)\nshort_bio: \(user.short_bio)\nage: \(user.age)\nexperience_level: \(user.experience_level)\nsurboard_type: \(user.surboard_type)\nsurf_status: \(user.surf_status)\nprimary_location_lat: \(user.primary_location_lat)\nprimary_location_long: \(user.primary_location_long)")
    }
    
    func getEmail() -> String {
        print("Getting email: \(self.email)")
        return self.email
    }
    
    func getPassword() -> String {
        print("Getting password: \(self.password)")
        return self.password
    }
    
//    User Data
//    public var username: String
//    public var full_name: String
//    public var short_bio: String
//    public var age: Int
//    public var experience_level: Int
//    public var surboard_type: Int
//    public var surf_status: Int
//    public var primary_location_lat: Float
//    public var primary_location_long: Float
//
//    private var email: String
//    private var password: String
    
}
