//
//  EventRowView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import SwiftUI

struct EventRowView: View {
  let event: Event
  
  var body: some View {
    HStack {
      Image(systemName: event.symbol)
        .sfSymbolStyling()
        .foregroundStyle(event.color)
        .frame(width: 35, alignment: .center)
        .aspectRatio(contentMode: .fit)
      
      VStack(alignment: .leading, spacing: 5) {
        Text(event.title)
          .bold()
        
        Text(event.date.formatted(date: .abbreviated, time: .shortened))
          .font(.caption2)
          .foregroundStyle(.secondary)
      }
      
      if event.isCompleted {
        Spacer()
        
        Image(systemName: "checkmark")
          .sfSymbolStyling()
          .foregroundStyle(.secondary)
      }
    }
    .badge(event.remainingTaskCount)
  }
}

#Preview {
  EventRowView(event: SampleData.shared.event)
    .modelContainer(SampleData.shared.container)
}
