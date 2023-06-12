//
//  Initiate.swift
//  FODComDemo
//
//  Created by Amanda Beyers on 6/7/23.
//


import SundialKit
import SwiftUI

public class InitiateWatchApp {
    public var connectivityObject = WatchConnectivityObject()
    
    public init() {
        connectivityObject.activate()
    }
    
    public func checkConnectivity() {
        if connectivityObject.isPairedAppInstalled {
            print("AppInstalled")
        } else {
            print("No installed")
        }
        if connectivityObject.isPaired {
            print("Paired")
        } else {
            print("Not Paired")
        }
        if connectivityObject.isReachable {
            print("Reachable")
        } else {
            print("Not Reachable")
        }
    }
    
    public func sendMessage() {
        connectivityObject.sendMessage()
        guard let workout = WorkoutInfo(from: ["displayName" : "Alice", "age" : 32, "facilityId" : "FacilityID", "facilityName" : "San Diego", "activityTypeId" : 37, "activityName" : "running"])
        else {return}
        connectivityObject.sendData(content: workout)
    }
}
