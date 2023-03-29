//
//  InfoView.swift
//  TeamMinder
//
//  Created by Simon Fortelny on 3/27/23.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject var team: Team
    @ObservedObject var member: TeamMember
    
    init(member: TeamMember) {
        self.member = member
    }
    
    var body: some View {
        VStack {
            VStack{
                HStack {
                    Text("Name")
                    Spacer()
                }
                HStack {
                    TextField("Name", text: $member.name)
                }
            }
            VStack{
                HStack {
                    Text("City")
                    Spacer()
                }
                HStack {
                    TextField("City", text: $member.city)
                }
            }
            VStack{
                HStack {
                    Text("Notes")
                    Spacer()
                }
                HStack {
                    TextField("Notes", text: $member.notes, axis: .vertical)
                        .lineLimit(5...10)
                }
            }
            VStack{
                HStack {
                    Text("Family")
                    Spacer()
                }
                HStack {
                    TextField("Family", text: $member.family, axis: .vertical)
                        .lineLimit(5...10)
                }
            }
            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    team.deleteMember(member: member)
                }) {
                    Text("Remove").foregroundColor(.red)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.red, lineWidth: 2)
               ).padding(4.0)
            }
        }.padding([.leading, .trailing], 10)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(member: testTeamData().members[0])
    }
}
