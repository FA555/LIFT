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
  
  private init() {
    let schema = Schema([
      Friend.self,
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
    } catch {
      print("Failed to delete existing friends: \(error)")
    }
    
    for friend in Friend.sampleData {
      context.insert(friend)
    }
    
    do {
      try context.save()
    } catch {
      print("Failed to save sample data: \(error)")
    }
  }
}
