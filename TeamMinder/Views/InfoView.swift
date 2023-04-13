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
            TMTextEditor($member.name)
            
            TitleText("City")
            TMTextEditor($member.city)
            
            TitleText("Notes")
            TMTextEditor($member.notes)
            
            TitleText("Family")
            TMTextEditor($member.family)
            Spacer()
            
            HStack {
                Spacer()
                TMButton(color: .red, action: {
                    team.deleteMember(member: member)
                }, text: "Remove team member")
                
                TMButton(color: .blue, action: {
                    exportUser(member: member)
                }, text: "Export user data")
            }
        }.padding([.leading, .trailing], 10)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(member: TestData.teamTestData.members[0])
    }
}
