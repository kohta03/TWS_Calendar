//
//  CalendarView.swift
//  TWS_Calendar
//
//  Created by 濱本洸多 on 2021/05/30.
//

import SwiftUI
import FSCalendar
import UIKit

struct CalendarTestView: UIViewRepresentable {
    var calendarEvent: [CalendarEvent]
    @Binding var selectedDate: Date
    @Binding var isOpenEventDetails: Bool
    @Binding var eventTargetAry: [CalendarEvent]
    @Binding var eventIsOpenAry: [Bool]
    
    func makeUIView(context: Context) -> UIView {
        typealias UIViewType = FSCalendar
        let fsCalendar = FSCalendar()
        fsCalendar.delegate = context.coordinator
        fsCalendar.dataSource = context.coordinator
            
        //表示
        fsCalendar.scope = .month //表示の単位（週単位 or 月単位）
        fsCalendar.locale = Locale(identifier: "en") //表示の言語の設置（日本語表示の場合は"ja"）
        //ヘッダー
        fsCalendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 20) //ヘッダーテキストサイズ
        fsCalendar.appearance.headerDateFormat = "yyyy/MM" //ヘッダー表示のフォーマット
        fsCalendar.appearance.headerTitleColor = UIColor.label //ヘッダーテキストカラー
        fsCalendar.appearance.headerMinimumDissolvedAlpha = 0 //前月、翌月表示のアルファ量（0で非表示）
        //曜日表示
        fsCalendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 18) //曜日表示のテキストサイズ
        fsCalendar.appearance.weekdayTextColor = .darkGray //曜日表示のテキストカラー
        fsCalendar.appearance.titleWeekendColor = .red //週末（土、日曜の日付表示カラー）
        //カレンダー日付表示
        fsCalendar.appearance.titleFont = UIFont.systemFont(ofSize: 16) //日付のテキストサイズ
        fsCalendar.appearance.titleFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold) //日付のテキスト、ウェイトサイズ
        fsCalendar.appearance.todayColor = .clear //本日の選択カラー
        fsCalendar.appearance.titleTodayColor = .green //本日のテキストカラー
            
        fsCalendar.appearance.selectionColor = .cyan //選択した日付のカラー
        fsCalendar.appearance.titleSelectionColor = .white // 選択した日付のテキストカラー
        fsCalendar.appearance.borderSelectionColor = .blue //選択した日付のボーダーカラー
        fsCalendar.appearance.titleSelectionColor = .black //選択した日付のテキストカラー
            
        return fsCalendar
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator{
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        let dateFormatter = DateFormatter()
        var parent: CalendarTestView
        
        init(_ parent: CalendarTestView){
            self.parent = parent
        }
        
        func formatEventStart(start: String) -> String {
            let fromIndex = start.startIndex
            let toIndex = start.index(fromIndex, offsetBy: 9)
            return String(start[fromIndex ... toIndex])
        }
        
        // イベントのある日を登録
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            for event in parent.calendarEvent{
                guard let eventDate = dateFormatter.date(from: formatEventStart(start: event.start) ) else { return 0 }
                if date.compare(eventDate) == .orderedSame{
                    return 1
                }
            }
            return 0
        }
        
        // カレンダーがタップされた際
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let eventTargetAry = parent.calendarEvent.filter{event in
                let eventDateStr = formatEventStart(start: event.start)
                let targetDateStr = dateFormatter.string(from: date)
                if eventDateStr == targetDateStr {
                    return true
                }
                return false
            }
            
            parent.selectedDate = date
            parent.eventTargetAry = eventTargetAry
            parent.isOpenEventDetails = !eventTargetAry.isEmpty
            parent.eventIsOpenAry = [Bool](repeating: false, count: !eventTargetAry.isEmpty ? eventTargetAry.count : 0)
        }
    }
}

struct CalendarView: View {
    @Binding var calendarEvent: [CalendarEvent]
    @State var selectedDate = Date()
    @State var isOpenEventDetails = false
    @State var eventTargetAry: [CalendarEvent] = []
    @State var eventIsOpenAry: [Bool] = []
    
    var body: some View {
        ZStack {
            CalendarTestView(calendarEvent: calendarEvent, selectedDate: $selectedDate, isOpenEventDetails: $isOpenEventDetails, eventTargetAry: $eventTargetAry, eventIsOpenAry: $eventIsOpenAry)
                .frame(height: 400)
            
            if self.isOpenEventDetails {
                EventModalView(selectedDate: $selectedDate, eventTargetAry: $eventTargetAry, eventIsOpenAry: $eventIsOpenAry)
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(calendarEvent: .constant([]))
    }
}
