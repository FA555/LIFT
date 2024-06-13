//
//  EventView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import SwiftUI
import SwiftData

struct EventView: View {
  @Bindable var event: Event
  let isEditing: Bool
  @State private var isPickingSymbol = false
  
  var body: some View {
    List {
      Section {
        if isEditing {
          HStack {
            Button {
              isPickingSymbol.toggle()
            } label: {
              Image(systemName: event.symbol)
                .sfSymbolStyling()
                .foregroundStyle(event.color)
                .opacity(0.75)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 5)
            
            TextField("Event title", text: $event.title)
              .font(.title2)
              .fontWeight(.semibold)
              .foregroundStyle(.gray)
          }
          
          DatePicker("Date", selection: $event.date)
            .labelsHidden()
        } else {
          HStack {
            Image(systemName: event.symbol)
              .sfSymbolStyling()
              .foregroundStyle(event.color)
              .padding(.horizontal, 5)
            
            Text(event.title)
              .font(.title2)
              .fontWeight(.semibold)
          }
          
          HStack {
            Text(event.date, style: .date)
            Text(event.date, style: .time)
          }
        }
      }
      .listRowSeparator(.hidden)
      
      Section {
        ForEach($event.tasks.sorted { $lhs, $rhs in
          lhs.addTime < rhs.addTime
        }) { $task in
          TaskRowView(task: $task, isEditing: isEditing)
        }
        .onDelete { indexSet in
          let sortedTasks = event.tasks.sorted { lhs, rhs in
            lhs.addTime < rhs.addTime
          }
          var indexSetToBeRemoved: IndexSet = []
          for index in indexSet {
            indexSetToBeRemoved.insert(event.tasks.firstIndex {
              $0.id == sortedTasks[index].id
            }!)
          }
          event.tasks.remove(atOffsets: indexSetToBeRemoved)
        }
        
        Button {
          event.tasks.append(Task(text: "", isNew: true))
        } label: {
          HStack {
            Image(systemName: "plus")
            Text("Add Task")
          }
        }
        .buttonStyle(.borderless)
      } header: {
        Text("Tasks")
          .bold()
          .font(.callout)
      }
    }
    .navigationTitle("Task")
    .navigationBarTitleDisplayMode(.inline)
    .sheet(isPresented: $isPickingSymbol) {
      SymbolPickerView(event: event)
    }
  }
}

#Preview {
  EventView(event: SampleData.shared.event, isEditing: false)
    .modelContainer(SampleData.shared.container)
}

#Preview {
  EventView(event: SampleData.shared.event, isEditing: true)
    .modelContainer(SampleData.shared.container)
}
