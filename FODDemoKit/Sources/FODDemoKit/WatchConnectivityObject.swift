//
//  WatchConnectivityObject.swift
//  FODComDemo
//
//  Created by Amanda Beyers on 5/22/23.
//

import SwiftUI
import SundialKit

@objc(WatchConnectivityObject) class WatchConnectivityObject : NSObject, ObservableObject {
    
    // our ConnectivityObserver
    let connectivityObserver = ConnectivityObserver()
    
    // create a `MessageDecoder` which can decode our new `WorkoutInfo` type
    let messageDecoder = MessageDecoder(messagableTypes: [WorkoutInfo.self])
    
    // our published property for isReachable initially set to false
    @Published var isReachable : Bool = false
    @Published var isPaired : Bool = false
    @Published var isPairedAppInstalled : Bool = false
    @Published var lastReceivedMessage : String = ""
    @Published var workoutEnded : String?
    @Published var workoutInfo : WorkoutInfo?
    @Published var reactRecieved: String = ""
    
    override init () {
        super.init()
        // set the isReachable changes to our published property
        connectivityObserver
            .isReachablePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &self.$isReachable)
        
        connectivityObserver
            .isPairedPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &self.$isPaired)
        
        connectivityObserver
            .isPairedAppInstalledPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &self.$isPairedAppInstalled)

        connectivityObserver
            .messageReceivedPublisher
            .compactMap({ received in
                received.message["workoutEnded"] as? String
            })
            .receive(on: DispatchQueue.main)
            .assign(to: &self.$workoutEnded)
    }
    
    func activate () {
        // activate the WatchConnectivity session
        try! self.connectivityObserver.activate()
    }
    
    func sendData(content: WorkoutInfo) {
        self.connectivityObserver.sendingMessageSubject.send(content.message())
    }
    
    @objc func setReactString() {
        reactRecieved = "SUCCESS"
    }
}
