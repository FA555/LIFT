//
//  SymbolPickerView.swift
//  LIFT
//
//  Created by 法伍 on 2024/6/13.
//

import SwiftUI

struct SymbolPickerView: View {
  @Bindable var event: Event
  @State private var selectedColor: Color = ColorOptions.default.color
  @Environment(\.dismiss) private var dismiss
  @State private var symbolNames = Symbols.list
  @State private var searchInput = ""
  
  let columns = Array(repeating: GridItem(.flexible()), count: 6)
  
  var body: some View {
    VStack {
      HStack {
        Spacer()
        
        Button {
          dismiss()
        } label: {
          Text("Done")
        }
        .padding([.top, .trailing])
      }
      
      Image(systemName: event.symbol)
        .font(.title)
        .imageScale(.large)
        .foregroundStyle(selectedColor)
        .frame(minHeight: 50, alignment: .center)
        .padding()
      
      HStack {
        ForEach(ColorOptions.allCases, id: \.self) { colorOption in
          let color = colorOption.color
          
          Button {
            selectedColor = color
            event.colorRaw = colorOption.rawValue
          } label: {
            Circle()
              .foregroundStyle(color)
          }
        }
      }
      .padding(.horizontal)
      .frame(height: 40)
      
      Divider()
      
      ScrollView {
        LazyVGrid(columns: columns) {
          ForEach(symbolNames, id: \.self) { symbolName in
            Button {
              event.symbol = symbolName
            } label: {
              Image(systemName: symbolName)
                .sfSymbolStyling()
                .foregroundStyle(selectedColor)
                .padding(5)
            }
            .buttonStyle(.plain)
          }
        }
        .drawingGroup()
      }
    }
    .onAppear {
      selectedColor = event.color
    }
  }
}

#Preview {
  SymbolPickerView(event: SampleData.shared.event)
    .modelContainer(SampleData.shared.container)
}
