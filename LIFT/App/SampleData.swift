//
//  SampleData.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import Foundation
import SwiftData

// Singleton class to manage sample data for the application
@MainActor
class SampleData {
  // Shared instance of SampleData for use throughout the app
  static let shared = SampleData()

  // ModelContainer to manage data models
  let container: ModelContainer

  // Accessor for the main context of the ModelContainer
  var context: ModelContext {
    container.mainContext
  }

  // Accessor for a sample Friend object
  var friend: Friend {
    Friend.sampleData[0]
  }

  // Accessor for a sample Event object
  var event: Event {
    Event.sampleData[2]
  }

  // Accessor for a sample Task object
  var task: Task {
    Task(text: "Wait for full charge")
  }

  // Private initializer to set up the ModelContainer and insert sample data
  private init() {
    // Define the schema including Friend and Event models
    let schema = Schema([
      Friend.self,
      Event.self,
    ])
    // Configure the model container with the schema
    let configuration = ModelConfiguration(schema: schema)

    do {
      // Create and assign the ModelContainer instance
      container = try ModelContainer(
        for: schema, configurations: [configuration]
      )

      // Insert sample data into the context
      insertSampleData()
    } catch {
      // Handle errors during ModelContainer creation
      fatalError("Failed to create ModelContainer: \(error)")
    }
  }

  // Method to insert sample data into the context
  private func insertSampleData() {
    do {
      // Delete existing data in the context
      try context.delete(model: Friend.self)
      try context.delete(model: Event.self)
    } catch {
      // Print an error message if deletion fails
      print("Failed to delete existing Friends or Event: \(error)")
    }

    // Insert sample Friend data into the context
    for friend in Friend.sampleData {
      context.insert(friend)
    }

    // Insert sample Event data into the context
    for event in Event.sampleData {
      context.insert(event)
    }

    do {
      // Save the context to persist the sample data
      try context.save()
    } catch {
      // Print an error message if saving fails
      print("Failed to save sample data: \(error)")
    }
  }
}
