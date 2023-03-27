//
//  ContentView.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/23/23.
//

import SwiftUI



struct ContentView: View {
    @ObservedObject var team: Team
    
    var body: some View {
        NavigationSplitView {
            Sidebar(team: team)
        } detail: {
            TeamMemberView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(team: testTeamData())
    }
}
