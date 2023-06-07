//
//  ContentView.swift
//  FODComDemo
//
//  Created by Amanda Beyers on 5/18/23.
//

import SwiftUI

struct ContentView: View {
    @State var info = WorkoutInfo(displayName: "", age: 0, facilityId: "", facilityName: "", activityTypeId: 0, activityName: "")
    @StateObject var connectivityObject = WatchConnectivityObject()
    
    var body: some View {
        if connectivityObject.isPaired {
            if connectivityObject.isPairedAppInstalled {
                if connectivityObject.workoutEnded == nil {
                    VStack {
                        HStack {
                            Text("Name")
                            TextField(
                                "User name",
                                text: $info.displayName
                            )
                            .border(.secondary)
                        }
                        HStack {
                            Text("Age")
                            TextField(
                                "Age",
                                value: $info.age,
                                format: .number
                            )
                            .border(.secondary)
                        }
                        HStack {
                            Text("Facility ID")
                            TextField(
                                "ID",
                                text: $info.facilityId
                            )
                            .border(.secondary)
                        }
                        HStack {
                            Text("Facility Name")
                            TextField(
                                "Name",
                                text: $info.facilityName
                            )
                            .border(.secondary)
                        }
                        HStack {
                            Text("Activity Name")
                            TextField(
                                "Workout Name",
                                text: $info.activityName
                            )
                            .textInputAutocapitalization(.never)
                            .border(.secondary)
                        }
                        HStack {
                            Text("Activity Type ID")
                            TextField(
                                "ID",
                                value: $info.activityTypeId,
                                format: .number
                            )
                            .border(.secondary)
                        }
                        Button("Submit") {
                            self.connectivityObject.sendData(content: info)
                        }
                        Text(connectivityObject.reactRecieved)
                    }
                    .padding()
                } else {
                    Text("Nicely done! Keep up the good work!")
                    Button("Start Over") {
                        self.connectivityObject.workoutEnded = nil
                        info = WorkoutInfo(displayName: "", age: 0, facilityId: "", facilityName: "", activityTypeId: 0, activityName: "")
                    }
                }
            } else {
                Text("App not installed on watch")
                Text(connectivityObject.reactRecieved)
            }
        } else {
            Text(connectivityObject.reactRecieved)
            Text("Watch not paired.")
                .onAppear {
                self.connectivityObject.activate()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
