/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 The workout controls.
 */

import SwiftUI

struct ControlsView: View {
    @ObservedObject var workoutManager: WorkoutManager
    @ObservedObject var connectivityObject: WatchConnectivityObject
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        TimelineView(MetricsTimelineSchedule(from: workoutManager.builder?.startDate ?? Date(), isPaused: workoutManager.session?.state == .paused)) { context in
            VStack {
                ElapsedTimeView(elapsedTime: workoutManager.builder?.elapsedTime(at: context.date) ?? 0, showSubseconds: context.cadence == .live)
                    .foregroundStyle(.yellow)
                Button {
                    workoutManager.endWorkout()
                    connectivityObject.endWorkout()
                    self.presentation.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
                .tint(.red)
                .font(.title2)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            workoutManager.startWorkout(workoutType: .running)
        }
    }
}

private struct MetricsTimelineSchedule: TimelineSchedule {
    var startDate: Date
    var isPaused: Bool
    
    init(from startDate: Date, isPaused: Bool) {
        self.startDate = startDate
        self.isPaused = isPaused
    }
    
    func entries(from startDate: Date, mode: TimelineScheduleMode) -> AnyIterator<Date> {
        var baseSchedule = PeriodicTimelineSchedule(from: self.startDate, by: (mode == .lowFrequency ? 1.0 : 1.0 / 30.0))
            .entries(from: startDate, mode: mode)
        
        return AnyIterator<Date> {
            guard !isPaused else { return nil }
            return baseSchedule.next()
        }
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView(workoutManager: WorkoutManager(), connectivityObject: WatchConnectivityObject())
    }
}
