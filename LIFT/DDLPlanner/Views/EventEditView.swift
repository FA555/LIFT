//
//  EventEditView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import SwiftUI
import SwiftData

struct EventEditView: View {
  @Binding var event: Event
  var isNew = false
  //  @State private var isDeleted = false
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var context
  @Query private var events: [Event]
  
  @State private var eventCopy = Event()
  @State private var isEditing = false
  
  //  private var isEventDeleted: Bool {
  //    !events.contains(event) && !isNew
  //  }
  //
  var body: some View {
    EventView(event: $eventCopy, isEditing: isNew || isEditing)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          if isNew {
            Button("Cancel") {
              dismiss()
            }
          }
        }
        
        ToolbarItem {
          Button {
            if isNew {
              context.insert(eventCopy)
              dismiss()
            } else {
              if isEditing {
                withAnimation {
                  event = eventCopy
                }
              }
              
              isEditing.toggle()
            }
          } label: {
            Text(isNew ? "Add" : isEditing ? "Done" : "Edit")
          }
        }
      }
      .onAppear {
        eventCopy = event
      }
  }
}

#Preview {
  EventEditView(event: .constant(SampleData.shared.event))
    .modelContainer(SampleData.shared.container)
}
