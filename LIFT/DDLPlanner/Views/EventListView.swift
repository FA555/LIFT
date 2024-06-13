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
  @State private var newEvent: Event?
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(EventCatetory.allCases) { category in
          let eventsInCategory = events
            .filter {
              $0.category == category
            }
            .sorted {
              $0.date < $1.date
            }
          
          if !eventsInCategory.isEmpty {
            Section {
              ForEach(eventsInCategory) { event in
                NavigationLink {
                  EventEditView(event: event)
                } label: {
                  EventRowView(event: event)
                }
              }
            } header: {
              let view = Text(NSLocalizedString(category.name, comment: ""))
                .font(.callout)
              
              if category == .past {
                view.foregroundStyle(.secondary)
              } else {
                view.bold()
              }
              
              view
            }
          }
        }
        .onDelete {
          deleteEvents(at: $0)
        }
      }
      .navigationTitle("Events")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem {
          Button {
            let newEvent_ = Event()
            context.insert(newEvent_)
            DispatchQueue.main.async {
              newEvent = newEvent_
            }
          } label: {
            Label("Add Event", systemImage: "plus")
          }
        }
      }
      .sheet(item: $newEvent) { event in
        NavigationStack {
          EventEditView(event: event, isNew: true)
        }
      }
    }
  }
  
  private func deleteEvents(at offsets: IndexSet) {
    for offset in offsets {
      context.delete(events[offset])
    }
  }
}

#Preview {
  EventListView()
    .modelContainer(SampleData.shared.container)
}
