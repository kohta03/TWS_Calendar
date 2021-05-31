//
//  CalendarEvent.swift
//  TWS_Calendar
//
//  Created by 濱本洸多 on 2021/05/30.
//

import Foundation

struct CalendarEvent: Decodable, Identifiable {
    var id: String
    var title: String
    var description: String
    var start: String
    var end: String
}
