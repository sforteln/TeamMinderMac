//
//  ContentView.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/23/23.
//

import SwiftUI



struct ContentView: View {
    @EnvironmentObject var team: Team
    @State private var showAddUserSheet = false
    @State private var selection: TeamMember?
    var body: some View {
        NavigationSplitView {
            List(selection: $selection){
                Text("Team")
                    .font(.headline)
                Divider()
                ForEach(team.members, id: \.name) { member in
//                    NavigationLink(value: member) {
//                        Text(member.name)
//                    }
                    TeamMemberSidebarCell(member: member)
                }
                Spacer()
            }
            
            Button(action: {
                showAddUserSheet.toggle()
            }, label: {
                Label("Add Teammate", systemImage: "person.fill.badge.plus").font(.subheadline)
            })
            .padding([.leading, .trailing], 2.0)
            .padding(.bottom, 4.0)
            .sheet(isPresented: $showAddUserSheet) { AddTeamMemberSheet() }
        } detail: {
            if let member = selection {
                TeamMemberView(member: member)
            } else if team.members.count == 0{
                Text("<-- Add your team")
            } else {
                Text("Select a team member")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(testTeamData())
    }
}
