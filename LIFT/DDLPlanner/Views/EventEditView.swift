//
//  EventEditView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import SwiftData
import SwiftUI

struct EventEditView: View {
  @Bindable var event: Event
  var isNew = false
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var context

  @State private var isEditing = false

  var body: some View {
    NavigationStack {
      EventView(event: event, isEditing: isNew || isEditing)
        .toolbar {
          ToolbarItem(placement: .cancellationAction) {
            if isNew {
              Button("Cancel") {
                context.delete(event)
                dismiss()
              }
            }
          }

          ToolbarItem {
            Button {
              if isNew {
                dismiss()
              } else {
                isEditing.toggle()
              }
            } label: {
              Text(isNew ? "Add" : isEditing ? "Done" : "Edit")
            }
          }
        }
    }
  }
}

#Preview {
  EventEditView(event: SampleData.shared.event)
    .modelContainer(SampleData.shared.container)
}
