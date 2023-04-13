//
//  Performance.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 4/1/23.
//

import SwiftUI
struct PerformanceView: View {
    @EnvironmentObject var team: Team
    @ObservedObject var member: TeamMember
    var body: some View {
        List {
            Text("Thoughts, comments, and feedback that would be useful when doing their performance review")
            
            TitleText("Good")
            TMTextEditor($member.performanceGood)
                
            TitleText("Needs Improvement")
            TMTextEditor($member.performanceNeedsImprovement)
        }
    }
    
}
