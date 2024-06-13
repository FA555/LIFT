//
//  BirthdaysListView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import SwiftUI
import SwiftData

struct FriendsListView: View {
  @Query(sort: \Friend.birthday) private var friends: [Friend]
  @Environment(\.modelContext) private var context
  @State private var newFriend: Friend?
  
  init(nameFilter: String = "") {
    let predicate = #Predicate<Friend> { friend in
      return nameFilter.isEmpty || friend.name.localizedStandardContains(nameFilter)
    }
    
    _friends = Query(filter: predicate, sort: \Friend.birthday)
  }
  
  var body: some View {
    Group {
      if !friends.isEmpty {
        List {
          ForEach(friends) { friend in
            NavigationLink {
              FriendDetailView(friend: friend)
            } label: {
              HStack {
                if friend.isBirthdayToday {
                  Image(systemName: "birthday.cake")
                }
                
                Text(friend.name)
                  .bold(friend.isBirthdayToday)
                
                Spacer()
                
                Text(friend.birthday, style: .date)
              }
            }
          }
          .onDelete(perform: deleteFriends)
        }
      } else {
        ContentUnavailableView {
          Label("No friends", systemImage: "person.3.fill")
        }
        .background(Color(.systemGroupedBackground))
      }
    }
    .navigationTitle("Birthdays")
    .toolbar {
#if !os(watchOS)
      ToolbarItem(placement: .topBarTrailing) {
        EditButton()
      }
#endif
      
      ToolbarItem {
        Button(action: addFriend) {
          Label("Add Friend", systemImage: "plus")
        }
      }
    }
    .sheet(item: $newFriend) { friend in
      NavigationStack {
        FriendDetailView(friend: friend, isNew: true)
      }
      .interactiveDismissDisabled()
    }
  }
  
  private func addFriend() {
    withAnimation {
      let newFriend_ = Friend(name: "", birthday: .now)
      context.insert(newFriend_)
      DispatchQueue.main.async {
        newFriend = newFriend_
      }
//      newFriend = newFriend_
    }
  }
  
  private func deleteFriends(at offsets: IndexSet) {
    for offset in offsets {
      context.delete(friends[offset])
    }
  }
}

#Preview("Empty list") {
  NavigationStack {
    FriendsListView()
  }
}

#Preview {
  NavigationStack {
    FriendsListView()
      .modelContainer(SampleData.shared.container)
  }
}
