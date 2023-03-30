//
//  TrendsView.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/29/23.
//

import SwiftUI
import Charts

struct TrendDataPoint: Identifiable {
    var level: Int
    var date: Date
    var id = UUID()
}

struct TrendData: Identifiable {
    var id = UUID()
    var points : [TrendDataPoint]
    var title : String
    
    func addNewPoint(level: Int) {
        
    }

}

func daysAgo(_ ago: Int) -> Date {
    return Date(timeIntervalSinceNow: TimeInterval(ago * -86400))
}

struct TrendsView: View {
    var data : [TrendData]
    
    var body: some View {
        List {
            ForEach(data) { datum in
                TrendsChartView(trendData: datum)
            }
        }
    }
}

struct TrendsChartView: View {
    var trendData : TrendData
    var body: some View {
        VStack{
            Text(trendData.title).font((.largeTitle))
            Chart {
                ForEach(trendData.points) { trendPoint in
                    LineMark(
                        x: .value("date", trendPoint.date),
                        y: .value("scale", trendPoint.level)
                    )
                }
            }
            .chartYScale(domain: [1,5])
            
            VStack{
                HStack{
                    Text("Add today").font(.title3).padding(.leading, 10)
                    Spacer()
                }.padding(.bottom,1)
                HStack{
                    EmojiButton(emoji: "😟", label: "1", action: {})
                    EmojiButton(emoji: "😕", label: "2", action: {})
                    EmojiButton(emoji: "😐", label: "3", action: {})
                    EmojiButton(emoji: "😀", label: "4", action: {})
                    EmojiButton(emoji: "😎", label: "5", action: {})
                    Spacer()
                }.padding([.leading,.bottom], 20)
            }
            
        }
        Spacer()
    }
}

struct EmojiButton: View {
    var emoji : String
    var label : String
    var action : () -> Void
    var body: some View {
        VStack{
            Button(action: action) {
                Text(" \(emoji) ")
            }.font(.largeTitle).buttonStyle(.plain)
            Text(label)
        }.background(.white).cornerRadius(10)
    }
}

struct TrendsView_Previews: PreviewProvider {
    static var previews: some View {
        var points: [TrendDataPoint] = [
            TrendDataPoint(level: 2, date: daysAgo(12)),
            TrendDataPoint(level: 3, date: daysAgo(22)),
            TrendDataPoint(level: 1, date: daysAgo(23)),
            TrendDataPoint(level: 1, date: daysAgo(30)),
            TrendDataPoint(level: 5, date: daysAgo(33)),
            TrendDataPoint(level: 4, date: daysAgo(43)),
            TrendDataPoint(level: 5, date: daysAgo(47)),
            TrendDataPoint(level: 5, date: daysAgo(53)),
            TrendDataPoint(level: 3, date: daysAgo(60)),
            TrendDataPoint(level: 3, date: daysAgo(67)),
            TrendDataPoint(level: 2, date: daysAgo(73)),
            TrendDataPoint(level: 1, date: daysAgo(80)),
            TrendDataPoint(level: 4, date: daysAgo(87)),
            TrendDataPoint(level: 1, date: daysAgo(93)),
            TrendDataPoint(level: 3, date: daysAgo(100))
        ]
        let trendData1 = TrendData(points: points, title: "How stessed")
        let trendData2 = TrendData(points: points, title: "How burned out")
        let trendData3 = TrendData(points: points, title: "How happy")
        TrendsView(data: [trendData1, trendData2, trendData3])
    }
}



