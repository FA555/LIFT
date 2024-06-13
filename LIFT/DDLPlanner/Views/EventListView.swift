//
//  EventListView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import SwiftUI
import SwiftData

struct EventListView: View {
  @Environment(\.modelContext) private var context
  @Query(sort: \Event.date) private var events: [Event]
  @State private var isAddNewEvent = false
  @State private var newEvent = Event()
  
  var body: some View {
    List {
//      ForEach(EventCatetory.allCases) { category in
//        let eventsInCategory = events
//          .filter {
//            $0.category == category
//          }
//          .sorted {
//            $0.date < $1.date
//          }
//        
//        if !eventsInCategory.isEmpty {
//          Section {
//            ForEach(eventsInCategory) { event in
//              NavigationLink {
//                EventEditView(event: .constant(event))
//              } label: {
//                EventRowView(event: event)
//              }
//            }
//          } header: {
//            Text(category.name)
//              .font(.callout)
//              .foregroundStyle(.secondary)
//              .bold()
//          }
//        }
//      }
      ForEach(events) { $event in
        NavigationLink {
          EventEditView(event: $event)
        } label: {
          EventRowView(event: event)
        }
      }
    }
  }
  
//  func sortedEventsInCategory(category: EventCatetory) -> Binding<[Event]> {
//    Binding<[Event]>(
//      get: {
//        self.events
//          .filter {
//            $0.category == category
//          }
//          .sorted {
//            $0.date < $1.date
//          }
//      },
//      set: { events in
//        for event in events {
//          if let index = self.events.firstIndex(where: { $0.id == event.id }) {
//            self.events[index] = event
//          }
//        }
//      }
//    )
//  }
}

#Preview {
  EventListView()
    .modelContainer(SampleData.shared.container)
}
