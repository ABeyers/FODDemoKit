//
//  Initiate.swift
//  FODComDemo
//
//  Created by Amanda Beyers on 6/7/23.
//


import SundialKit
import SwiftUI

public class InitiateApp {
    @StateObject public var connectivityObject = WatchConnectivityObject()
    
    public init() {
        connectivityObject.activate()
        connectivityObject.sendMessage()
    }
}
