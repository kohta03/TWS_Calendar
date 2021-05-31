//
//  ContentView.swift
//  TWS_Calendar
//
//  Created by 濱本洸多 on 2021/05/29.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var calendarVM = CalendarViewModel()
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            ZStack {
                if calendarVM.isLoading {
                    LoadingView()
                } else {
                    TopView(calendarEvent: $calendarVM.calendarEvent)
                }
            }
            .tabItem {
                VStack {
                    Image(systemName: "a")
                    Text("TodayList")
                }
            }
            ZStack {
                if calendarVM.isLoading {
                    LoadingView()
                } else {
                    CalendarView(calendarEvent: $calendarVM.calendarEvent)
                }
            }
            .tabItem {
                VStack {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
