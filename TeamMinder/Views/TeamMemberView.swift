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
            TrendsView()
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

