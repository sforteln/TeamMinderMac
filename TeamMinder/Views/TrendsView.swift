//
//  TrendsView.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/29/23.
//

import SwiftUI
import Charts

struct TrendsView: View {
    @EnvironmentObject var team: Team
    @ObservedObject var member : TeamMember
    
    var body: some View {
        if member.trends.count > 0 {
            List {
                ForEach(member.trends) { datum in
                    if let trend = team.trends.first { $0.id == datum.trendId }{
                        TrendsChartView(trendData: datum,trend: trend)
                    }
                }
            }
        } else {
            VStack {
                Spacer()
                Text("Add a trend to your team to start tracking it for each member. You can do this using the button in the left sidebar.").font((.title2))
                Image(systemName: "arrow.left").font(.title2)
                Spacer()
            }
        }
    }
}

struct TrendsChartView: View {
    @ObservedObject var trendData : TrendData
    @ObservedObject var trend : Trend
    var body: some View {
        VStack{
            VStack {
                HStack {
                    Spacer()
                    Text(trend.title).font((.largeTitle))
                    Spacer()
                }
                Text("(\(trend.type.rawValue))")
            }.padding(.bottom,2)
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
                    let emoji = emojiFor(trendType: trend.type)
                    EmojiButton(emoji: emoji[0],
                                label: "1",
                                action: {trendData.addNewPoint(level: 1)})
                    EmojiButton(emoji: emoji[1],
                                label: "2",
                                action: {trendData.addNewPoint(level: 2)})
                    EmojiButton(emoji: emoji[2],
                                label: "3",
                                action: {trendData.addNewPoint(level: 3)})
                    EmojiButton(emoji: emoji[3],
                                label: "4",
                                action: {trendData.addNewPoint(level: 4)})
                    EmojiButton(emoji: emoji[4],
                                label: "5",
                                action: {trendData.addNewPoint(level: 5)})
                    Spacer()
                }.padding([.leading,.bottom], 20)
            }
            
        }
        Spacer()
    }
}

private func emojiFor(trendType : TrendType) -> [String] {
    let emoji = ["😟", "😕","😐","😀","😎"]
    if trendType == .lowerIsBetter {
        return emoji.reversed()
    }
    return emoji
}

struct EmojiButton: View {
    var emoji : String
    var label : String
    var action : () -> Void
    var body: some View {
        VStack{
            Button(action: action) {
                VStack {
                    Text(" \(emoji) ").font(.largeTitle)
                    Text(label).padding(.bottom,2)
                }
            }.buttonStyle(.plain)
            
        }.background(Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 1.0))
            .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 1)
        )
    }
}

struct TrendsView_Previews: PreviewProvider {
    static var previews: some View {

        TrendsView(member: TestData.teamTestData.members[0]).environmentObject(TestData.teamTestData)
    }
}



