//
//  CalendarViewModel.swift
//  TWS_Calendar
//
//  Created by 濱本洸多 on 2021/05/30.
//

import Foundation

class CalendarViewModel: ObservableObject {
    let fetcher  = CalendarEventFetcher()
    
    @Published var calendarEvent: [CalendarEvent] = []
    @Published var isLoading: Bool = true
    
    init() {
        self.fetcher.fetchCalendarEvent { (events) in
            sleep(1)
            self.calendarEvent = events
            self.isLoading = false
        }
    }
}
