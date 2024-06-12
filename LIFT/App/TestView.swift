//
//  ContentView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/12.
//

import SwiftUI
import SwiftData

struct TestView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var items: [TestItem]
  
  var body: some View {
    NavigationSplitView {
      List {
        ForEach(items) { item in
          NavigationLink {
            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
          } label: {
            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
          }
        }
        .onDelete(perform: deleteItems)
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
        ToolbarItem {
          Button(action: addItem) {
            Label("Add Item", systemImage: "plus")
          }
        }
      }
    } detail: {
      Text("Select an item")
    }
  }
  
  private func addItem() {
    withAnimation {
      let newItem = TestItem(timestamp: Date())
      modelContext.insert(newItem)
    }
  }
  
  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(items[index])
      }
    }
  }
}

#Preview {
  TestView()
    .modelContainer(for: TestItem.self, inMemory: true)
}
