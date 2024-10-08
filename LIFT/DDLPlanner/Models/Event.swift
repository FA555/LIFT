//
//  Event.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import Foundation
import SwiftData
import SwiftUI

// Enum to categorize events based on their dates
enum EventCategory: String, Identifiable, CaseIterable {
  case withinWeek = "In 7 Days"
  case withinMonth = "In 30 Days"
  case future = "Future"
  case past = "Past"

  // Conforming to Identifiable protocol
  var id: String {
    rawValue
  }

  // Name property for the category
  var name: String {
    rawValue
  }
}

// Model class representing an Event
@Model
class Event: Identifiable, Hashable {
  // Sample data for testing and development
  static let sampleData: [Event] = [
    Event(
      symbol: "airplane", color: .indigo, title: "Travel to Paris",
      tasks: [
        Task(text: "Pack clothes"),
        Task(text: "Check in online"),
        Task(text: "Get to airport"),
      ],
      date: Date.now.daysOut(-3)
    ),
    Event(
      symbol: "archivebox.fill", color: .green, title: "Submit LIFT",
      tasks: [
        Task(text: "Write README"),
        Task(text: "Push to GitHub"),
        Task(text: "Submit to App Store"),
      ],
      date: Date.now.daysOut(1)
    ),
    Event(
      symbol: "arrow.down.left.circle.fill", color: .orange,
      title: "Charge iPhone",
      tasks: [
        Task(text: "Plug in charger"),
        Task(text: "Wait for full charge"),
      ],
      date: Date.now.daysOut(2)
    ),
    Event(
      symbol: "bell.fill", color: .red, title: "Meeting with John",
      tasks: [
        Task(text: "Prepare presentation"),
        Task(text: "Send meeting invite"),
      ],
      date: Date.now.daysOut(5)
    ),
    Event(
      symbol: "bicycle", color: .purple, title: "Bike to Work",
      tasks: [
        Task(text: "Check tire pressure"),
        Task(text: "Pack lunch"),
      ],
      date: Date.now.daysOut(7)
    ),
    Event(
      symbol: "bolt.fill", color: .green, title: "Fix Light Bulb",
      tasks: [
        Task(text: "Buy new light bulb"),
        Task(text: "Replace light bulb"),
      ],
      date: Date.now.daysOut(10)
    ),
    Event(
      symbol: "bandage.fill", color: .yellow, title: "Get Vaccinated",
      tasks: [
        Task(text: "Make appointment"),
        Task(text: "Bring ID"),
      ],
      date: Date.now.daysOut(14)
    ),
    Event(
      symbol: "balloon.fill", color: .indigo, title: "Birthday Party",
      tasks: [
        Task(text: "Buy gift"),
        Task(text: "RSVP"),
      ],
      date: Date.now.daysOut(30)
    ),
    Event(
      symbol: "book.fill", color: .green, title: "Read Book",
      tasks: [
        Task(text: "Buy book"),
        Task(text: "Read 10 pages"),
      ],
      date: Date.now.daysOut(45)
    ),
    Event(
      symbol: "briefcase.fill", color: .yellow, title: "Job Interview",
      tasks: [
        Task(text: "Research company"),
        Task(text: "Prepare questions"),
      ],
      date: Date.now.daysOut(60)
    ),
  ]

  // Properties of the Event model
  var id = UUID()
  var symbol: String
  var colorRaw: String
  var title: String
  var tasks: [Task]
  var date: Date

  // Computed property to get the corresponding SwiftUI Color
  var color: Color {
    ColorOptions(rawValue: colorRaw).map { $0.color } ?? .accentColor
  }

  // Initializer to create an empty Event instance
  init() {
    self.symbol = Symbols.random
    self.colorRaw = ColorOptions.random.rawValue
    self.title = ""
    self.tasks = [Task(text: "")]
    self.date = Date()
  }

  // Initializer to create an Event instance with specified properties
  init(
    symbol: String, color colorOption: ColorOptions, title: String,
    tasks: [Task], date: Date
  ) {
    self.symbol = symbol
    self.colorRaw = colorOption.rawValue
    self.title = title
    self.tasks = tasks
    self.date = date
  }

  // Computed property to get the count of remaining tasks
  var remainingTaskCount: Int {
    tasks.filter { !$0.isCompleted }.count
  }

  // Computed property to check if all tasks are completed
  var isCompleted: Bool {
    tasks.allSatisfy { $0.isCompleted }
  }

  // Computed property to check if the event date is in the past
  var isPast: Bool {
    date < Date.now
  }

  // Computed property to check if the event is within a week
  var isWithinWeek: Bool {
    Date.now < date && date < Date.now.daysOut(7)
  }

  // Computed property to check if the event is within a month
  var isWithinMonth: Bool {
    Date.now.daysOut(7) <= date && date < Date.now.daysOut(30)
  }

  // Computed property to check if the event is in the future
  var isFuture: Bool {
    Date.now.daysOut(30) <= date
  }

  // Computed property to get the event category
  var category: EventCategory {
    if date < Date.now {
      return .past
    }

    if date < Date.now.daysOut(7) {
      return .withinWeek
    }

    if date < Date.now.daysOut(30) {
      return .withinMonth
    }

    return .future
  }

  // Conformance to Equatable protocol
  static func == (lhs: Event, rhs: Event) -> Bool {
    lhs.id == rhs.id
  }

  // Conformance to Hashable protocol
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

// Extension to add a utility method to Date
extension Date {
  // Method to get a date offset by a number of days
  func daysOut(_ days: Int) -> Date {
    Calendar.autoupdatingCurrent.date(byAdding: .day, value: days, to: self)!
  }
}
