//
//  LIFTApp.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/12.
//

import SwiftData
import SwiftUI

// Main entry point for the LIFT application
@main
struct LIFTApp: App {
  // Shared model container for the app
  var sharedModelContainer: ModelContainer = {
    // Define the schema including Friend and Event models
    let schema = Schema([
      Friend.self,
      Event.self,
    ])
    // Configure the model container with the schema and storage option
    let modelConfiguration = ModelConfiguration(
      schema: schema, isStoredInMemoryOnly: false
    )

    do {
      // Create and return the ModelContainer instance
      return try ModelContainer(
        for: schema, configurations: [modelConfiguration])
    } catch {
      // Handle errors during ModelContainer creation
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()

  // Define the body of the application
  var body: some Scene {
    // Create the main window group for the app
    WindowGroup {
      ContentView()
    }
    // Attach the shared model container to the scene
    .modelContainer(sharedModelContainer)
  }
}
