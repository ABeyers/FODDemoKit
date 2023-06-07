//
//  WorkoutInfo.swift
//  FODComDemo
//
//  Created by Amanda Beyers on 5/19/23.
//

import Foundation
import SundialKit

struct WorkoutInfo: Messagable {
    var displayName : String
    var age : Int
    var facilityId : String
    var facilityName : String
    var activityTypeId : Int
    var activityName : String
    
    enum Parameters : String {
      case displayName
        case age
        case facilityId
        case facilityName
        case activityTypeId
        case activityName
    }
    
    internal init(displayName: String, age: Int, facilityId: String, facilityName: String, activityTypeId: Int, activityName: String) {
        self.displayName = displayName
        self.age = age
        self.facilityId = facilityId
        self.facilityName = facilityName
        self.activityTypeId = activityTypeId
        self.activityName = activityName
    }
    
    static var key: String = "WorkoutInfo"
    
    init?(from parameters: [String : Any]?) {
        guard let displayName = parameters?[Parameters.displayName.rawValue] as? String else {return nil}
        guard let age = parameters?[Parameters.age.rawValue] as? Int else {return nil}
        guard let facilityId = parameters?[Parameters.facilityId.rawValue] as? String else {return nil}
        guard let facilityName = parameters?[Parameters.facilityName.rawValue] as? String else {return nil}
        guard let activityTypeId = parameters?[Parameters.activityTypeId.rawValue] as? Int else {return nil}
        guard let activityName = parameters?[Parameters.activityName.rawValue] as? String else {return nil}
        
        self.displayName = displayName
        self.age = age
        self.facilityId = facilityId
        self.facilityName = facilityName
        self.activityTypeId = activityTypeId
        self.activityName = activityName
    }
    
    func parameters() -> [String : Any] {
        return [
            Parameters.displayName.rawValue : self.displayName,
            Parameters.age.rawValue : self.age,
            Parameters.facilityId.rawValue : self.facilityId,
            Parameters.facilityName.rawValue : self.facilityName,
            Parameters.activityTypeId.rawValue : self.activityTypeId,
            Parameters.activityName.rawValue : self.activityName
        ]
    }
}
