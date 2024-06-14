//
//  FilteredFriendsListView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import SwiftUI

struct FilteredFriendsListView: View {
  @State private var searchText = ""

  var body: some View {
    NavigationStack {
      FriendsListView(nameFilter: searchText)
        .searchable(text: $searchText)
    }
  }
}

#Preview {
  FilteredFriendsListView()
    .modelContainer(SampleData.shared.container)
}
