//
//  FriendDetailView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import SwiftUI

struct FriendDetailView: View {
  @Bindable var friend: Friend
  let isNew: Bool
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var context
  
  init(friend: Friend, isNew: Bool = false) {
    self.friend = friend
    self.isNew = isNew
  }
  
  var body: some View {
    Form {
      TextField("Name", text: $friend.name)
      
      DatePicker("Birthday", selection: $friend.birthday, displayedComponents: [.date])
    }
    .toolbar {
      if isNew {
        ToolbarItem(placement: .confirmationAction) {
          Button("Done") {
            dismiss()
          }
        }
        
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") {
            context.delete(friend)
            dismiss()
          }
        }
      }
    }
    .navigationTitle(isNew ? "New Friend" : "Friend")
  }
}

#Preview {
  NavigationStack {
    FriendDetailView(friend: SampleData.shared.friend)
  }
  .modelContainer(SampleData.shared.container)
}

#Preview {
  NavigationStack {
    FriendDetailView(friend: SampleData.shared.friend, isNew: true)
  }
  .modelContainer(SampleData.shared.container)
}
