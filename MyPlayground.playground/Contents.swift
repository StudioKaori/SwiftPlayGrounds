import UIKit

import SwiftUI
import PlaygroundSupport

struct CalendarView: View {
    @State var selectedMonth = Date()

    var body: some View {
        TabView(selection: $selectedMonth) {
            MonthView(date: selectedMonth)
                .tabItem {
                    Label("Current Month", systemImage: "calendar")
                }
                .tag(selectedMonth)
            
            MonthView(date: selectedMonth.addingTimeInterval(60 * 60 * 24 * 31))
                .tabItem {
                    Label("Next Month", systemImage: "calendar")
                }
                .tag(selectedMonth.addingTimeInterval(60 * 60 * 24 * 31))
        }
        .onChange(of: selectedMonth) { newValue in
            // Prevent swipe back past current month
            if newValue < Date() {
                selectedMonth = Date()
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .navigationTitle("Calendar")
    }
}

struct MonthView: View {
    let date: Date

  func getDateString(date: Date, format: String = "yyyy/MM/dd") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
  }
    var body: some View {
        // Replace this with your own month view implementation
      Text("\(getDateString(date: date, format: "yyyy/MM"))")
            .font(.largeTitle)
            .padding()
    }
}


let view = CalendarView()
PlaygroundPage.current.setLiveView(view)
