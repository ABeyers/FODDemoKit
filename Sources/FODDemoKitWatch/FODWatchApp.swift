//
//  File.swift
//  
//
//  Created by Amanda Beyers on 6/12/23.
//

import Foundation
import SwiftUI

public protocol FODWatchApp: App {
  
}

public extension FODWatchApp {
  var body: some Scene {
      WindowGroup {
          WatchWorkoutView()
      }
  }
}
