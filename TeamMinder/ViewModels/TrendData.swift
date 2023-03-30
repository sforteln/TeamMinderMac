//
//  TrendData.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/30/23.
//

import Foundation
class TrendDataPoint: Identifiable, ObservableObject {
    var level: Int
    var date: Date
    var id = UUID()
    
    init(level: Int, date: Date) {
        self.level = level
        self.date = date
    }
}

class TrendData: Identifiable,ObservableObject {
    var id = UUID()
    @Published var points : [TrendDataPoint]
    var title : String
    
    init(points: [TrendDataPoint], title: String) {
        self.points = points
        self.title = title
    }
    
    func addNewPoint(level: Int) {
        points.append(TrendDataPoint(level: level, date: Date.now))
    }
}


//Test data
extension Date {
    static func daysAgo(_ ago: Int) -> Date {
        return Date(timeIntervalSinceNow: TimeInterval(ago * -86400))
    }
}

func testTrendData() -> [TrendData] {
    var points: [TrendDataPoint] = [
        TrendDataPoint(level: 2, date: Date.daysAgo(12)),
        TrendDataPoint(level: 3, date: Date.daysAgo(22)),
        TrendDataPoint(level: 1, date: Date.daysAgo(23)),
        TrendDataPoint(level: 1, date: Date.daysAgo(30)),
        TrendDataPoint(level: 5, date: Date.daysAgo(33)),
        TrendDataPoint(level: 4, date: Date.daysAgo(43)),
        TrendDataPoint(level: 5, date: Date.daysAgo(47)),
        TrendDataPoint(level: 5, date: Date.daysAgo(53)),
        TrendDataPoint(level: 3, date: Date.daysAgo(60)),
        TrendDataPoint(level: 3, date: Date.daysAgo(67)),
        TrendDataPoint(level: 2, date: Date.daysAgo(73)),
        TrendDataPoint(level: 1, date: Date.daysAgo(80)),
        TrendDataPoint(level: 4, date: Date.daysAgo(87)),
        TrendDataPoint(level: 1, date: Date.daysAgo(93)),
        TrendDataPoint(level: 3, date: Date.daysAgo(100))
    ]
    let trendData1 = TrendData(points: points, title: "How stessed")
    let trendData2 = TrendData(points: points, title: "How burned out")
    let trendData3 = TrendData(points: points, title: "How happy")
    return [trendData1, trendData2, trendData3]
}
