//
//  CalendarEventFetcher.swift
//  TWS_Calendar
//
//  Created by 濱本洸多 on 2021/05/29.
//

import Foundation

class CalendarEventFetcher {
    private let url = Bundle.main.object(forInfoDictionaryKey: "CALENDAR_API_URL") as! String
    
    func fetchCalendarEvent(completion: @escaping ([CalendarEvent]) -> Void) {
        var request = URLRequest(url: URL(string: "https://\(url)")!)
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("Bearer \(Bundle.main.object(forInfoDictionaryKey: "CALENDAR_API_AUTH_TOKEN") as! String)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            guard let data  = data else { return }
            
            let decoder: JSONDecoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            do {
                let result = try decoder.decode([CalendarEvent].self, from: data)
                DispatchQueue.main.async {
                    completion(result.sorted(by: { (prev, next) -> Bool in
                        return prev.start < next.start
                    }))
                }
            } catch {
                print("json convert failed in JSONDecoder. " + error.localizedDescription)
            }
        }.resume()
    print("end fetchCalendarEvent func")
    }
}
