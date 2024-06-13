//
//  SampleData.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
  static let shared = SampleData()
  
  let container: ModelContainer
  
  var context: ModelContext {
    container.mainContext
  }
  
  var friend: Friend {
    Friend.sampleData[0]
  }
  
  var event: Event {
    Event.sampleData[2]
  }
  
  var task: Task {
    Task(text: "Wait for full charge")
  }
  
  private init() {
    let schema = Schema([
      Friend.self,
      Event.self,
    ])
    let configuration = ModelConfiguration(schema: schema)
    
    do {
      container = try ModelContainer(for: schema, configurations: [configuration])
      
      insertSampleData()
    } catch {
      fatalError("Failed to create ModelContainer: \(error)")
    }
  }
  
  private func insertSampleData() {
    do {
      try context.delete(model: Friend.self)
      try context.delete(model: Event.self)
    } catch {
      print("Failed to delete existing Friends or Event: \(error)")
    }
    
    for friend in Friend.sampleData {
      context.insert(friend)
    }
    
    for event in Event.sampleData {
      context.insert(event)
    }
    
    do {
      try context.save()
    } catch {
      print("Failed to save sample data: \(error)")
    }
  }
}
