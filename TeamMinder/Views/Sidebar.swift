//
//  sidebar.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/27/23.
//

import SwiftUI

struct Sidebar: View {
    @ObservedObject var team: Team

    var body: some View {
        List {
                ForEach(team.members, id: \.name) { member in
                    Text(member.name)
                }
            }
            .navigationTitle("Team")
    }
}

struct sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar(team: testTeamData())
    }
}
