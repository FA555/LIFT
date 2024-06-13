//
//  TaskRowView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import SwiftUI

struct TaskRowView: View {
  @Binding var task: Task
  var isEditing: Bool = false
  @FocusState private var isFocused: Bool
  
  var body: some View {
    HStack {
      if isEditing || task.isNew {
        Button {
          task.isCompleted.toggle()
        } label: {
          Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
        }
        .buttonStyle(.plain)
        
        TextField("Task description", text: $task.text)
          .focused($isFocused)
          .onChange(of: isFocused) { _, newValue in
            if !newValue {
              task.isNew = false
            }
          }
      } else {
        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
          .foregroundStyle(.secondary)
        
        Text(task.text)
      }
      
      Spacer()
    }
    .padding(.vertical, 10)
    .task {
      if task.isNew {
        isFocused = true
      }
    }
  }
}

#Preview {
  TaskRowView(task: .constant(SampleData.shared.task))
    .modelContainer(SampleData.shared.container)
}
