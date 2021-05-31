//
//  TopView.swift
//  TWS_Calendar
//
//  Created by 濱本洸多 on 2021/05/30.
//

import SwiftUI

struct TodayEventView: View {
    @Binding var calendarEvent: [CalendarEvent]
    private var todayEventAry: [CalendarEvent] = []
    
    init(calendarEvent: Binding<[CalendarEvent]>) {
        self._calendarEvent = calendarEvent
        todayEventAry = getTodayEvent(calendarEvent: self.calendarEvent)
    }
    
    func getTodayEvent(calendarEvent: [CalendarEvent]) -> [CalendarEvent] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return calendarEvent.filter{event in
            let fromIndex = event.start.startIndex
            let toIndex = event.start.index(fromIndex, offsetBy: 9)
            let eventDateStr = String(event.start[fromIndex ... toIndex])
            let targetDateStr = dateFormatter.string(from: Date())
            if eventDateStr == targetDateStr {
                return true
            }
            return false
        }
    }
    
    var body: some View {
        if !self.todayEventAry.isEmpty {
            List {
                ForEach(0 ..< todayEventAry.count, id: \.self) { index in
                    Group {
                        Text("タイトル: \(todayEventAry[index].title)")
                        Text("説明: \(todayEventAry[index].description)")
                    }
                }
            }
        } else {
            Text("本日、予定はありません！")
        }
    }
}

struct TopView: View {
    @Binding var calendarEvent: [CalendarEvent]
    
    var body: some View {
        VStack {
            Text("本日の予定")
            TodayEventView(calendarEvent: $calendarEvent)
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView(calendarEvent: .constant([]))
    }
}
