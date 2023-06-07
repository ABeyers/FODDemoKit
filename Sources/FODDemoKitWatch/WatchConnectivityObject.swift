//
//  WatchConnectivityObject.swift
//  FODComDemo
//
//  Created by Amanda Beyers on 5/22/23.
//

import SwiftUI
import SundialKit

public class WatchConnectivityObject : ObservableObject {
    
    // our ConnectivityObserver
    
    let connectivityObserver = ConnectivityObserver()
    
    // create a `MessageDecoder` which can decode our new `WorkoutInfo` type
    let messageDecoder = MessageDecoder(messagableTypes: [WorkoutInfo.self])
    
    @Published var workoutInfo : WorkoutInfo?
    @Published public var messageFromPhone : String = "NO MESSAGE"
    
    public override init () {
        super.init()
        connectivityObserver
            .messageReceivedPublisher
        // get the ``ConnectivityReceiveResult/message`` part of the ``ConnectivityReceiveResult``
            .map(\.message)
        // use our `messageDecoder` to call ``MessageDecoder/decode(_:)``
            .compactMap(self.messageDecoder.decode)
        // check it's a WorkoutInfo message
            .compactMap{$0 as? WorkoutInfo}
            .receive(on: DispatchQueue.main)
        // set it to our published property
            .assign(to: &self.$workoutInfo)
        
        connectivityObserver
            .messageReceivedPublisher
            .compactMap({ received in
                received.message["message"] as? String
            })
            .receive(on: DispatchQueue.main)
            .assign(to: &self.$messageFromPhone)
    }
    
    public  func activate () {
        // activate the WatchConnectivity session
        try! self.connectivityObserver.activate()
    }
    
    public func endWorkout() {
        workoutInfo = nil
        self.connectivityObserver.sendingMessageSubject.send(["workoutEnded" : ""])
    }
}
