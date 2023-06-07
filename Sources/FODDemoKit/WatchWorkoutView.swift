//
//  ContentView.swift
//  WatchFODComDemo Watch App
//
//  Created by Amanda Beyers on 5/18/23.
//

import SwiftUI
import HealthKit

@available(iOS 16.0, *)
public struct WatchWorkoutView: View {
    @StateObject var connectivityObject = WatchConnectivityObject()
//    @StateObject var workoutManager = WorkoutManager()
    @State private var isActive = false
    
    public var body: some View {
        VStack {
            if let workoutInfo = connectivityObject.workoutInfo {
                NavigationStack {
                    VStack(alignment: .leading){
                        Text("Welcome \(workoutInfo.displayName),")
                        Text("let's start \(workoutInfo.activityName)")
                        Text("at the \(workoutInfo.facilityName) Facility.")
                    }
//                    NavigationLink(destination: ControlsView(workoutManager: workoutManager, connectivityObject: connectivityObject)) {
//                        Text("Start Workout")
//                    }
                }
                .onAppear {
                    self.connectivityObject.activate()
                }
            } else {
                Spacer()
                Image(systemName: "hourglass")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Waiting For Class Info...")
                Spacer()
                Button("Get Help") {
                    
                }
                .onAppear {
                    self.connectivityObject.activate()
//                    workoutManager.requestAuthorization()
                }
            }
        }
        .padding()
    }
}

@available(iOS 16.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return Group {
            WatchWorkoutView()
                .previewDevice("Apple Watch Series 5 - 44mm")
            
            WatchWorkoutView()
                .previewDevice("Apple Watch Series 5 - 40mm")
        }
    }
}
