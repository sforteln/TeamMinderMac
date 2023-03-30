//
//  TeamMemberView.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/27/23.
//

import SwiftUI

struct TeamMemberView: View {
    @EnvironmentObject var team: Team
    @ObservedObject var member: TeamMember
    var body: some View {
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
        
        TabView {
            InfoView(member: member)
            .tabItem {
                Label("Info", systemImage:"info.circle")
            }
            QuestionsView(member: member)
            .tabItem {
                Label("Questions", systemImage: "questionmark.bubble")
            }
            CompletedQuestionsView(member: member)
            .tabItem {
                Label("Completed Questions", systemImage: "questionmark.bubble")
            }
            TrendsView(data: [trendData1, trendData2, trendData3])
            .tabItem {
                Label("Trends", systemImage: "questionmark.bubble")
            }
        }
    }
}

struct NoTeamViewOfFull: View {
    
    var body: some View {
        Text("<-- Add your team")
    }
}

struct TeamMemberView_Previews: PreviewProvider {
    static var previews: some View {
        TeamMemberView(member: testTeamData().members[0]).environmentObject(testTeamData())
    }
}

