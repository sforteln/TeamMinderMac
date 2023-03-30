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
        List {
            TitleText("Name")
            TMSingleLineTextField($member.name)
            
            TitleText("City")
            TMSingleLineTextField($member.city)
            
            TitleText("Notes")
            TMTextField($member.notes)
            
            TitleText("Family")
            TMTextField($member.family)
            Spacer()
            
            HStack {
                Spacer()
                TMButton(color: .red, action: {
                    team.deleteMember(member: member)
                }, text: "Remove")
                
            }
        }.padding([.leading, .trailing], 10)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(member: testTeamData().members[0])
    }
}
